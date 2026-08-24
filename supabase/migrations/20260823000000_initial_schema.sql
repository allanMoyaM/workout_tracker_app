-- =============================================
-- EnerGym — Schema inicial
-- Corre este script en: Supabase Dashboard → SQL Editor → New query
-- =============================================

-- =============================================
-- TABLAS
-- =============================================

-- Perfil del usuario (1:1 con auth.users)
CREATE TABLE public.user_profiles (
  id                    UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name                  TEXT NOT NULL DEFAULT '',
  title                 TEXT NOT NULL DEFAULT 'ATHLETE',
  badge                 TEXT NOT NULL DEFAULT 'BRONZE',
  level                 INTEGER NOT NULL DEFAULT 1,
  weight_kg             DECIMAL(5,2),
  height_cm             DECIMAL(5,2),
  body_fat_percent      DECIMAL(4,2),
  target_weight_kg      DECIMAL(5,2),
  weekly_session_target INTEGER NOT NULL DEFAULT 4,
  notifications_enabled BOOLEAN NOT NULL DEFAULT TRUE,
  theme_mode            TEXT NOT NULL DEFAULT 'dark',   -- 'dark' | 'light' | 'system'
  locale                TEXT NOT NULL DEFAULT 'en',     -- 'en' | 'es'
  avatar_url            TEXT,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Historial de medidas corporales
CREATE TABLE public.user_measurements (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  weight_kg        DECIMAL(5,2),
  body_fat_percent DECIMAL(4,2),
  recorded_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Catálogo de ejercicios (globales + creados por usuario)
CREATE TABLE public.exercises (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name         TEXT NOT NULL,
  muscle_group TEXT NOT NULL,
  created_by   UUID REFERENCES auth.users(id) ON DELETE SET NULL,  -- NULL = ejercicio global
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Planes de entrenamiento
CREATE TABLE public.workouts (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name           TEXT NOT NULL,
  scheduled_date DATE,
  notes          TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Ejercicios dentro de un plan de entrenamiento
CREATE TABLE public.workout_exercises (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_id  UUID NOT NULL REFERENCES public.workouts(id) ON DELETE CASCADE,
  exercise_id UUID NOT NULL REFERENCES public.exercises(id),
  sets        INTEGER NOT NULL DEFAULT 3,
  reps        INTEGER NOT NULL DEFAULT 10,
  weight_kg   DECIMAL(5,2) NOT NULL DEFAULT 0,
  order_index INTEGER NOT NULL DEFAULT 0
);

-- Sesiones de entrenamiento completadas
CREATE TABLE public.workout_sessions (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  workout_id       UUID REFERENCES public.workouts(id) ON DELETE SET NULL,
  name             TEXT NOT NULL,
  started_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ended_at         TIMESTAMPTZ,
  duration_minutes INTEGER,
  calories         INTEGER,
  category         TEXT NOT NULL DEFAULT 'strength',  -- strength | cardio | recovery
  notes            TEXT
);

-- Sets ejecutados dentro de una sesión
CREATE TABLE public.session_sets (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id   UUID NOT NULL REFERENCES public.workout_sessions(id) ON DELETE CASCADE,
  exercise_id  UUID NOT NULL REFERENCES public.exercises(id),
  set_number   INTEGER NOT NULL,
  reps         INTEGER NOT NULL,
  weight_kg    DECIMAL(5,2) NOT NULL DEFAULT 0,
  velocity_ms  DECIMAL(4,3),
  completed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =============================================
-- FUNCIONES
-- =============================================

-- Crear perfil automáticamente al registrarse un usuario
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1))
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_user_profiles_updated_at
  BEFORE UPDATE ON public.user_profiles
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_workouts_updated_at
  BEFORE UPDATE ON public.workouts
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- =============================================
-- ROW LEVEL SECURITY (RLS)
-- Cada usuario solo puede ver y modificar sus propios datos
-- =============================================

ALTER TABLE public.user_profiles     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_measurements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exercises         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workouts          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workout_exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workout_sessions  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.session_sets      ENABLE ROW LEVEL SECURITY;

-- user_profiles
CREATE POLICY "Users can view own profile"
  ON public.user_profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile"
  ON public.user_profiles FOR UPDATE USING (auth.uid() = id);

-- user_measurements
CREATE POLICY "Users can manage own measurements"
  ON public.user_measurements FOR ALL USING (auth.uid() = user_id);

-- exercises: catálogo global de lectura, usuario edita solo los suyos
CREATE POLICY "Anyone can read exercises"
  ON public.exercises FOR SELECT USING (TRUE);
CREATE POLICY "Users can create exercises"
  ON public.exercises FOR INSERT WITH CHECK (auth.uid() = created_by);
CREATE POLICY "Users can update own exercises"
  ON public.exercises FOR UPDATE USING (auth.uid() = created_by);

-- workouts
CREATE POLICY "Users can manage own workouts"
  ON public.workouts FOR ALL USING (auth.uid() = user_id);

-- workout_exercises (acceso via el workout del usuario)
CREATE POLICY "Users can manage exercises in own workouts"
  ON public.workout_exercises FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.workouts
      WHERE workouts.id = workout_exercises.workout_id
        AND workouts.user_id = auth.uid()
    )
  );

-- workout_sessions
CREATE POLICY "Users can manage own sessions"
  ON public.workout_sessions FOR ALL USING (auth.uid() = user_id);

-- session_sets (acceso via la sesión del usuario)
CREATE POLICY "Users can manage sets in own sessions"
  ON public.session_sets FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.workout_sessions
      WHERE workout_sessions.id = session_sets.session_id
        AND workout_sessions.user_id = auth.uid()
    )
  );

-- =============================================
-- SEED DATA: Catálogo global de ejercicios
-- =============================================

INSERT INTO public.exercises (name, muscle_group) VALUES
  ('Bench Press',           'Chest'),
  ('Incline Bench Press',   'Chest'),
  ('Dumbbell Fly',          'Chest'),
  ('Cable Crossover',       'Chest'),
  ('Squat',                 'Legs'),
  ('Romanian Deadlift',     'Legs'),
  ('Leg Press',             'Legs'),
  ('Leg Curl',              'Legs'),
  ('Calf Raise',            'Legs'),
  ('Deadlift',              'Back'),
  ('Barbell Row',           'Back'),
  ('Pull-Up',               'Back'),
  ('Lat Pulldown',          'Back'),
  ('Seated Cable Row',      'Back'),
  ('Overhead Press',        'Shoulders'),
  ('Lateral Raise',         'Shoulders'),
  ('Face Pull',             'Shoulders'),
  ('Front Raise',           'Shoulders'),
  ('Bicep Curl',            'Arms'),
  ('Hammer Curl',           'Arms'),
  ('Tricep Pushdown',       'Arms'),
  ('Skull Crusher',         'Arms'),
  ('Plank',                 'Core'),
  ('Cable Crunch',          'Core'),
  ('Russian Twist',         'Core'),
  ('Hanging Leg Raise',     'Core'),
  ('Running',               'Cardio'),
  ('Cycling',               'Cardio'),
  ('Jump Rope',             'Cardio'),
  ('Rowing Machine',        'Cardio');
