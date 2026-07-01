# Contributing

Issue と Pull Request を歓迎します。

## 方針

- Matrixのプロトコル、E2EE、Federationは標準実装に寄せます。
- Cinny forkの差分は小さく保ち、upstream追従を優先します。
- 秘密値、実サーバのIP、証明書、signing key、DB dumpはコミットしないでください。

## 開発対象

- `client/`: Cinny forkを置く予定の場所
- `docs/`: 設計、運用、ロードマップ
- `compose.yaml`: 検証用デプロイ構成
- `scripts/`: 運用補助スクリプト

## Pull Request

PRには次を書いてください。

- 何を変えたか
- なぜ必要か
- 確認したこと
- 既知の未対応
