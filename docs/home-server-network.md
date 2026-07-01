# Home Server Network Notes

自宅LAN内のサーバー `192.168.11.30` に Matrix/Synapse + Cinny を置く場合のネットワーク要点です。

## Recommended setup

LAN:

- Home server: `192.168.11.30`
- Docker/Caddy: `80/tcp` and `443/tcp` listen on the home server

Router port forwarding:

- WAN `80/tcp` -> `192.168.11.30:80`
- WAN `443/tcp` -> `192.168.11.30:443`

DNS:

- `example.com` -> home WAN IP
- `matrix.example.com` -> home WAN IP
- `chat.example.com` -> home WAN IP

Matrix:

- `SERVER_NAME=example.com`
- `MATRIX_HOST=matrix.example.com`
- `CHAT_HOST=chat.example.com`
- `/.well-known/matrix/server` returns `{"m.server":"matrix.example.com:443"}`

With this pattern, federation can use `443/tcp`. You usually do not need to expose `8448/tcp`.

## When 8448 is needed

Matrix federation defaults to port `8448` when there is no delegation through `.well-known` or SRV.

If you do not serve:

```json
{"m.server":"matrix.example.com:443"}
```

from:

```text
https://example.com/.well-known/matrix/server
```

then other Matrix servers may try `example.com:8448`. In that case you must expose federation on `8448/tcp`, or fix delegation and keep using `443/tcp`.

## Common blockers

### CGNAT

If your router WAN address is in one of these ranges, inbound port forwarding from the internet usually will not work:

- `100.64.0.0/10`
- `10.0.0.0/8`
- `172.16.0.0/12`
- `192.168.0.0/16`

Fix options:

- ask the ISP for a public IPv4 address
- use IPv6 if your ISP provides stable inbound IPv6
- put a small VPS in front as a reverse proxy
- use a tunnel provider for client access, though federation compatibility needs separate testing

### Dynamic IP

If your public IP changes, use dynamic DNS or a DNS provider API updater. Matrix federation tolerates DNS changes, but bad or stale DNS will make invites and remote delivery flaky.

### Hairpin NAT

Some routers cannot access the public domain from inside the LAN. If `https://chat.example.com` works outside but not at home, this is likely hairpin NAT.

Fix options:

- enable NAT loopback / hairpin NAT on the router
- run split-horizon DNS at home
- add local DNS overrides so the domains resolve to `192.168.11.30` inside the LAN

### ISP blocked ports

Some residential ISPs block inbound `80/tcp`, `443/tcp`, or both.

Fix options:

- ask the ISP to unblock or switch plan
- use DNS-01 certificates and a nonstandard public port for client-only access
- use a VPS reverse proxy and WireGuard/Tailscale back to home

For Matrix federation, a normal public `443/tcp` path is the cleanest option.

## Security baseline

- Give `192.168.11.30` a static DHCP lease
- Keep only `80/tcp` and `443/tcp` forwarded
- Do not expose PostgreSQL
- Do not expose Synapse `8008/tcp` directly
- Keep Synapse behind Caddy
- Enable automatic OS security updates
- Back up PostgreSQL, Synapse media, and Synapse signing keys

## Quick external checks

From outside your home network:

```sh
curl -I https://chat.example.com
curl https://example.com/.well-known/matrix/server
curl https://matrix.example.com/_matrix/client/versions
```

Expected Matrix federation well-known:

```json
{"m.server":"matrix.example.com:443"}
```
