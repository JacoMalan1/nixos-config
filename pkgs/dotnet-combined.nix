{ dotnetCorePackages }:
(
  with dotnetCorePackages;
  combinePackages [
    sdk_6_0
    dotnet_8.sdk
    dotnet_9.sdk
    dotnet_10.sdk
  ]
).overrideAttrs
  (
    finalAttrs: previousAttrs: {
      postBuild = (previousAttrs.postBuild or "") + ''
        for i in $out/sdk/*
        do
          i=$(basename $i)
          mkdir -p $out/metadata/workloads/''${i/-*}
          touch $out/metadata/workloads/''${i/-*}/userlocal
        done
      '';
    }
  )
