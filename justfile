domain := "tuxy.party"

# Standard
check:
    nix flake check

deploy TARGET:
    nixos-rebuild switch \
        --flake .#{{ TARGET }} \
        --target root@{{ TARGET }}.{{ domain }} \
        --build-host localhost

update TARGET:
    nix flake update
    nix flake lock
    nixos-rebuild switch \
        --flake .#{{ TARGET }} \
        --target root@{{ TARGET }}.{{ domain }} \
        --build-host localhost

# Secrets management
agenix-edit SECRET:
    nix run .#agenix -- edit secrets/{{ SECRET }}.age

agenix-rekey:
    nix run .#agenix -- rekey

agenix-generate:
    nix run .#agenix -- generate

# Maintenance 
clean:
    nix-collect-garbage --delete-older-than 7d
    nix-store --optimise

hard-clean:
    sudo -v
    nix-collect-garbage --delete-old
    sudo nix-collect-garbage --delete-old
    nix-store --optimise
    sudo nix-store --optimise
