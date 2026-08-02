# NixOS Server config 

NixOS configuration for two servers using flake-parts.

## Structure

```
nixos-server/
├── flake.nix
├── flake.lock
├── .gitignore
├── modules/
│   ├── parts.nix
│   ├── agenix-rekey.nix
│   ├── features/
│   │   ├── copyparty/
│   │   └── nixflix/
│   └── hosts/
│       ├── server01/
│       │   ├── default.nix
│       │   ├── configuration.nix
│       │   └── hardware.nix
│       └── server02/
│           ├── default.nix
│           ├── configuration.nix
│           └── hardware.nix
└── secrets/
    ├── pubkeys/
    │   ├── server01.pub
    │   └── server02.pub
    └── rekeyed/
```

## Secrets workflow using just

# 1. Create/edit a secret (encrypted with single key on client only)
`just agenix-edit mysecret`

# 2. Wire it in a host config
`age.secrets.mysecret.rekeyFile = ../../../secrets/mysecret.age;`

# 3. Rekey for all hosts
`just agenix-rekey`

# 4. Deploy
`nixos-rebuild --flake .#target switch --target root@target`
