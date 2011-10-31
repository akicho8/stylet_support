DROP TABLE tetris;
CREATE TABLE tetris (
    mode TEXT,     -- モード
    grade TEXT,    -- グレード
    time TEXT,     -- タイム
    level INTEGER, -- レベル
    score INTEGER, -- スコア
    player TEXT,   -- プレイヤー
    playerid TEXT, -- プレイヤー番号
    username TEXT, -- ユーザ名
    date DATE,     -- プレイ日時
    filename TEXT  -- ファイル名
);
