let
  jacom_hotbox =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOF2arpGVPkPhmsSLlpx+gKVThKZvTObynPjB1TmMkV";
  users = [ jacom_hotbox ];

  hotbox =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZJY7XGSSmxVT991kZT1r3CYDdOphMMgE7zfabd63yB";
  systems = [ hotbox ];
in {
  "hotbox-monerod-conf.age".publicKeys = users ++ systems;
  "monero-mining-address.age".publicKeys = users ++ systems;
}
