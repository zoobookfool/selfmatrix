# Security Policy

## Reporting

セキュリティ問題を見つけた場合は、公開Issueに詳細な攻撃手順や秘密値を貼らないでください。

まずはメンテナーへ個別連絡するか、最小限の概要だけでIssueを作ってください。

## Do not commit

以下は絶対にコミットしないでください。

- `.env`
- Synapse signing key
- DB password
- `registration_shared_secret`
- Cloudflare Origin certificate/private key
- admin initial password
- DB dump
- media store backup
- 実サーバ固有の詳細な運用メモ

## E2EE note

E2EEはメッセージ本文を守りますが、サーバーにはメタデータ、ルーム状態、暗号化済みイベント、メディア、ログが残る場合があります。
