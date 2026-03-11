{ config, lib, inputs, ... }:

let
  spec = config.programs.nixvim.plugins.which-key.settings.spec;
  toLuaObject = inputs.nixvim.lib.nixvim.toLuaObject;
in {
  warnings = spec
    |> lib.map (group: { key = group.__unkeyed; mode = group.mode or "n"; })
    |> lib.unique
    |> lib.map (group:
      let
        all-defs = spec
          |> lib.filter (g:
              group.key == g.__unkeyed
              && lib.count (lib.intersectLists group.mode g.mode) != 0
            )
          |> lib.unique;
      in group // { inherit all-defs; })
    |> lib.filter (group: lib.length group.all-defs != 1)
    |> lib.map (group: ''
      Nixvim: which-key group with keybind '${group.key}' and modes '${toString group.mode}' defined multiple times.
      Group defs: ${toLuaObject group.all-defs}
    '');
}
