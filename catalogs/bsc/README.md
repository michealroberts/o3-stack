# Bright Stars

This dataset (`stars.json`) contains the 200 brightest named stars selected from the Yale Bright Star Catalog, enriched with positions, proper motions, magnitudes, and distance estimates.

The dataset follows the schema defined in `stars.schema.json`.

---

## File Layout

```json
{
  "$schema": "./stars.schema.json",
  "stars": [
    {
      "name": "Sirius",
      "alias": "α Canis Majoris",
      "constellation": "Canis Major",
      "RA": 101.28708333,
      "dec": -16.71611111,
      "μRA": -0.00015361,
      "μDec": -0.00033472,
      "m": -1.46000000,
      "M": 1.41015634,
      "distance": 2.66666667,
      "parallax": 0.00010417
    },
    ...
  ]
}
```

## Field Descriptions

| Field           | Type           | Description                                                                       |
|-----------------|----------------|-----------------------------------------------------------------------------------|
| `name`          | string         | IAU-approved proper name (e.g., `Sirius`).                                        |
| `alias`         | string         | Bayer designation with Greek letter where applicable (e.g., `α Canis Majoris`).   |
| `constellation` | string         | IAU constellation abbreviation (e.g., `Andromeda`, `Canis Major`).                |
| `RA`            | number         | Right ascension in **decimal degrees** at epoch/equinox J2000.                    |
| `dec`           | number         | Declination in **decimal degrees** at epoch/equinox J2000.                        |
| `μRA`           | number         | Proper motion in right ascension, in **degrees per year**.                        |
| `μDec`          | number         | Proper motion in declination, in **degrees per year**.                            |
| `distance`      | number \| null | Distance in **parsecs**. May be `null` if not available.                          |
| `parallax`      | number \| null | Parallax in **degrees**. May be `null` if not available.                          |
| `m`             | number \| null | Apparent magnitude. May be `null` if unknown.                                     |
| `M`             | number \| null | Absolute magnitude. May be `null` if unknown.                                     |
| `class`         | string \| null | Yerkes luminosity class (e.g., `V`, `III`, `Ib`). May be `null` if not available. |
| `type`          | string \| null | Morgan-Keenan spectral type (e.g., `A1V`). May be `null` if not available.        |
| `HR`            | string \| null | Harvard Revised Bright Star Catalog identifier. May be `null` if not available.   |
| `HD`            | string \| null | Henry Draper Catalog identifier. May be `null` if not available.                  |
| `flamsteed`     | string \| null | Flamsteed designation number. May be `null` if not available.                     |

---

## Notes

- All floating-point numbers are stored to precision of **8 decimal places**.  
- Parallax values are converted from arcseconds to **degrees**.  
- Magnitudes (`m` and `M`) are kept as numeric values when available, otherwise `null`.  