{ ... }:
{ kernelPatches = with builtins;
  let
    version = "5.2";
    sversion = "${version}.10";
    rtPatch = "patch-${sversion}-rt5.patch.gz";
    rtPatchUrl = https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt;
    rtPatchDir = fetchurl "${rtPatchUrl}/${version}/${rtPatch}";

    ntvPatch =
      "enable_additional_cpu_optimizations_for_gcc_v4.9+_kernel_v4.13+.patch";
  in
  [
    {
      name = "realtime patchset";
      patch = rtPatchDir;

      extraConfig =
      ''
      PREEMPT y
      PREEMPT_RT_FULL y
      RT_GROUP_SCHED? n

      IOSCHED_DEADLINE y
      DEFAULT_DEADLINE y
      DEFAULT_IOSCHED deadline

      HPET_TIMER y
      TREE_RCU_TRACE? n
      RT_GROUP_SCHED? n
      '';
    }
    # since we have to build the kernel anyway, might as well use march=native
    {
      name = "native-optimization";
      patch =
      "${builtins.fetchGit
         https://github.com/graysky2/kernel_gcc_patch}/${ntvPatch}"
      ;

      extraConfig =
      ''
      MNATIVE y
      '';
    }
  ];
}
