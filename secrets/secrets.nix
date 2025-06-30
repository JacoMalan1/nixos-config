let
  jacom_hotbox =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOF2arpGVPkPhmsSLlpx+gKVThKZvTObynPjB1TmMkV";
  jacom_django =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCL03C9JvZARKfXWKF4TgO7TOScLX/G3W9hZUy7Z8wD";
  users = [ jacom_hotbox jacom_django ];

  hotbox =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZJY7XGSSmxVT991kZT1r3CYDdOphMMgE7zfabd63yB";
  django =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ96MGmTqqnfKfiwEMaw7SjEzHNq+TLghOIw532DEoIJ";
  systems = [ hotbox django ];
in {
  "hotbox-monerod-conf.age".publicKeys = users ++ systems;
  "monero-mining-address.age".publicKeys = users ++ systems;
}
