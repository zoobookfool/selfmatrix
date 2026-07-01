# Architecture

## Product boundaries

このプロジェクトは「Matrixクライアントを丸ごと新規実装する」のではなく、Cinny のUI/導線をフォークで調整し、通信・連合・E2EEはMatrixとSynapseへ寄せます。

そのため、独自実装するのは主に以下です。

- ブランド、テーマ、アイコン、文言
- homeserver 固定化
- Discord風のサーバー/チャンネル見え方の調整
- 初回オンボーディング
- 暗号化、鍵バックアップ、端末検証の案内
- 管理者向けの運用手順

独自実装しないものは以下です。

- Federation protocol
- E2EE cryptography
- message sync protocol
- account/device/session primitives

## Domain model

Discord の「サーバー」は Matrix では基本的に Space で表現します。

- Discord server: Matrix Space
- Discord channel: Matrix Room
- private channel: invite-only encrypted Matrix Room
- DM: direct Matrix Room
- role/permission: Matrix power levels と Space/Room membership

## Operational model

MVPでは public registration を閉じ、管理者がユーザーを作成します。

Federation は初期状態では有効化しつつ、招待制コミュニティとして小さく始めます。荒らし・スパム・不正サーバー対策が必要になった段階で、server ACL、room policy、moderation bot、allow/block 方針を整えます。

## Data ownership

自前Synapseに以下を保持します。

- accounts and devices
- room state and events
- encrypted event payloads
- media repository
- server signing key
- local moderation/admin state

E2EEルームでは本文は暗号化されますが、サーバー運用者が完全に何も見えないわけではありません。バックアップ、ログ、メタデータ、Federation先の保持範囲はプロダクト説明でも曖昧にしない方がよいです。
