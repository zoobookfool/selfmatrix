# Roadmap

## Phase 0: Name and domain

- サービス名を決める
- `SERVER_NAME` を決める
- `matrix.*` と `chat.*` のDNSを決める
- ソース公開場所を決める

Exit criteria:

- `@user:domain` の形式に納得している
- ドメインを変えずに長期運用する判断ができている

## Phase 1: Vanilla deploy

- Synapse + PostgreSQL を起動
- Caddy でHTTPSとwell-knownを提供
- Cinny公式イメージを自分のhomeserver固定で公開
- admin user を作成
- テストユーザー2名で暗号化ルームを作る
- Federation tester で到達性を確認

Exit criteria:

- `chat.example.com` からログインできる
- `@alice:example.com` としてE2EEルームで会話できる
- 外部Matrixユーザーを招待できる、または方針として招待不可にしている

## Phase 2: Cinny fork

- fork repository を作る
- upstream追従用ブランチを作る
- AGPL notice と source link をUIに残す
- homeserver固定、featured communities非表示、文言差し替え
- Space/Room の見え方を「サーバー/チャンネル」寄りに調整
- 初回ログイン後に key backup と device verification を促す

Exit criteria:

- upstream rebase が現実的な差分量に収まっている
- ユーザーがMatrix用語を知らなくても使い始められる

## Phase 3: Operations hardening

- PostgreSQL dump の自動化
- media store と signing key のバックアップ
- restore drill
- rate limit と abuse対応
- registration policy
- admin/moderator手順
- uptime monitoring

Exit criteria:

- DB消失シナリオから復元できる
- signing key を失わない手順がある
- 荒らし対応の権限と手順が明文化されている

## Phase 4: Product polish

- 独自テーマ
- custom emoji/sticker 方針
- notification tuning
- mobile story
- SSO/OIDC
- moderation dashboard
- bridge/bot integrations

Exit criteria:

- 招待した人が説明なしで日常利用できる
- 運用者が毎日手作業で面倒を見なくても回る
