# Model-Based Design Tools for Simulink

MATLAB/Simulink toolbox for data-dictionary-driven Model-Based Design:
define interfaces once as data-dictionary objects, generate and verify
component dictionaries, run design checks and reports, validate with
MIL/SIL, and reuse vetted Simulink blocks.

## Contents

| Path | What it is |
| --- | --- |
| `Data_Management v3.0.0/` | Dictionary data classes (`+DataDict/`), base types (`+bt/`), fixed-point types (`+dt/`), helpers (`CommonFunctions/`), AUTOSAR aliases, `History_DataMgt.m` |
| `Tools v3.0.0/Design_Tools/` | `CreateDD`, `VerifyDD`, `STool` hub, keyword checks, DD/requirements/Model Advisor reports, packaging helpers |
| `Tools v3.0.0/Testing_Tools/` | `MIL` GUI, `Run_SIL`, test-definition parsing/validation (`NxtrTD*`), report/plot/signal helpers, `History_Tools.m` |
| `Nexteer_Utilities v5.0.0/Libraries/` | Reusable blocks: EA3 library, EA4 `Math` / `FixdPt` / `Intrpn` / `Fil` / `IMC`, `NvM_Library`, development library, `History_NxtrUtil.m` |
| `docs/` | Interactive documentation (published as a Pages site — nothing to install to read it) |

## Requirements

- MATLAB + Simulink.
- Some flows need additional MathWorks toolboxes (for example coverage or
  reporting during MIL validation). If a tool errors on a missing toolbox,
  install it and retry.

## Getting started

1. Put the folders you need on the MATLAB path:

```matlab
addpath(genpath('Data_Management v3.0.0'))
addpath(genpath('Tools v3.0.0'))
addpath(genpath('Nexteer_Utilities v5.0.0'))
savepath
```

2. Typical component flow:

```matlab
CreateDD('EA4')       % build "<FDD>_<ShortName>_DataDict.m" from workspace
VerifyDD('EA4', 'MyComp_DataDict')  % check naming, properties, consistency
STool                 % guided design-package hub
% then MIL / Run_SIL for validation
```

Use `'EA3'` instead of `'EA4'` for that architecture. Start with one FDD and
its dictionary before running batch flows.

## Documentation

Interactive documentation lives in [`docs/`](docs/) and is published as a
static Pages site — just open it, nothing to install. Notes for rebuilding
the site are in [`docs/README.md`](docs/README.md) (maintainers only).

## Versions

Each area tracks its own history in-tree:

- `Data_Management v3.0.0/History_DataMgt.m`
- `Tools v3.0.0/History_Tools.m`
- `Nexteer_Utilities v5.0.0/History_NxtrUtil.m`

Check the history file for the area you use before upgrading paths.

## Contributing

- Keep changes scoped to one area (`Data_Management`, `Tools`, libraries).
- Match the existing naming/keyword conventions so `VerifyDD` and keyword
  checks keep passing.
- For large changes, open an issue first to discuss the approach.

## License

No `LICENSE` file is currently present in this checkout. Check with the
maintainer before redistributing.
