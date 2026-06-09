-- ────────────────────────────────────────────────
-- 주가 지수 정보 시스템 - Supabase 초기 설정
-- Supabase 대시보드 > SQL Editor 에서 실행하세요
-- ────────────────────────────────────────────────

-- 관심종목 테이블 생성
CREATE TABLE IF NOT EXISTS public.watchlist (
    id         uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
    symbol     text        NOT NULL,
    name       text        NOT NULL,
    created_at timestamptz DEFAULT now()
);

-- Row Level Security 활성화
ALTER TABLE public.watchlist ENABLE ROW LEVEL SECURITY;

-- 공개 읽기/쓰기/삭제 허용 (로그인 없이 사용)
CREATE POLICY "public_select" ON public.watchlist
    FOR SELECT USING (true);

CREATE POLICY "public_insert" ON public.watchlist
    FOR INSERT WITH CHECK (true);

CREATE POLICY "public_delete" ON public.watchlist
    FOR DELETE USING (true);
