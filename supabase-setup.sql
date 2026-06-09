-- ────────────────────────────────────────────────
-- 주가 지수 정보 시스템 - Supabase 초기 설정
-- Supabase 대시보드 > SQL Editor 에서 실행하세요
-- ────────────────────────────────────────────────

-- 관심종목 테이블 생성 (KIS 방식 - market/type 컬럼 포함)
CREATE TABLE IF NOT EXISTS public.watchlist (
    id         uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
    symbol     text        NOT NULL,
    name       text        NOT NULL,
    market     text        DEFAULT 'KOR',   -- KOR / NAS / NYS
    type       text        DEFAULT 'kor-stock', -- kor-stock / kor-index / us
    created_at timestamptz DEFAULT now()
);

-- 기존 테이블에 컬럼 추가 (이미 테이블이 있는 경우)
ALTER TABLE public.watchlist ADD COLUMN IF NOT EXISTS market text DEFAULT 'KOR';
ALTER TABLE public.watchlist ADD COLUMN IF NOT EXISTS type   text DEFAULT 'kor-stock';

-- Row Level Security 활성화
ALTER TABLE public.watchlist ENABLE ROW LEVEL SECURITY;

-- 공개 읽기/쓰기/삭제 허용 (로그인 없이 사용)
CREATE POLICY IF NOT EXISTS "public_select" ON public.watchlist
    FOR SELECT USING (true);

CREATE POLICY IF NOT EXISTS "public_insert" ON public.watchlist
    FOR INSERT WITH CHECK (true);

CREATE POLICY IF NOT EXISTS "public_delete" ON public.watchlist
    FOR DELETE USING (true);
