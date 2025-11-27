DROP TABLE IF EXISTS public.feedback CASCADE;
DROP TABLE IF EXISTS public.progress CASCADE;
DROP TABLE IF EXISTS public.answer CASCADE;
DROP TABLE IF EXISTS public.exercise CASCADE;
DROP TABLE IF EXISTS public.lesson CASCADE;
DROP TABLE IF EXISTS public.topic CASCADE;
DROP TABLE IF EXISTS public.user CASCADE;

-- 2. Creación de Tablas

CREATE TABLE public.user (
  id_user integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  nickname character varying,
  password character varying,
  grade character varying,
  gender character varying,
  role character varying,
  CONSTRAINT user_pkey PRIMARY KEY (id_user)
);

CREATE TABLE public.topic (
  id_topic integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  topic_name character varying,
  description character varying,
  CONSTRAINT topic_pkey PRIMARY KEY (id_topic)
);

CREATE TABLE public.lesson (
  id_lesson integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  title character varying,
  id_topic integer,
  grade integer,
  state boolean,
  CONSTRAINT lesson_pkey PRIMARY KEY (id_lesson),
  CONSTRAINT lesson_id_topic_fkey FOREIGN KEY (id_topic) REFERENCES public.topic(id_topic)
);

CREATE TABLE public.exercise (
  id_exercise integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_lesson integer,
  data_answer boolean,
  CONSTRAINT exercise_pkey PRIMARY KEY (id_exercise),
  CONSTRAINT exercise_id_lesson_fkey FOREIGN KEY (id_lesson) REFERENCES public.lesson(id_lesson)
);

CREATE TABLE public.answer (
  id_answer integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  input_user text,
  score numeric,
  id_exercise integer,
  id_user integer,
  data_answer boolean,
  CONSTRAINT answer_pkey PRIMARY KEY (id_answer),
  CONSTRAINT answer_id_exercise_fkey FOREIGN KEY (id_exercise) REFERENCES public.exercise(id_exercise),
  CONSTRAINT answer_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user(id_user)
);

CREATE TABLE public.feedback (
  comentary text,
  id_lesson integer,
  id_answer integer,
  id_topic integer,
  id_user integer,
  CONSTRAINT feedback_id_lesson_fkey FOREIGN KEY (id_lesson) REFERENCES public.lesson(id_lesson),
  CONSTRAINT feedback_id_answer_fkey FOREIGN KEY (id_answer) REFERENCES public.answer(id_answer)
);

CREATE TABLE public.progress (
  id_user integer,
  total_score numeric,
  state boolean,
  id_lesson integer,
  id_exercise integer,
  CONSTRAINT progress_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.user(id_user)
);