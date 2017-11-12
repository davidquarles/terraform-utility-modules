terraform-utility-modules
=========================

Generic HCL abuse :stuck_out_tongue_winking_eye:

Catalog
-------
* [**nested_map_lookup**](nested_map_lookup) - Null-safe lookup / retrieval of _flat_ maps, nested at arbitrary depth.
  - Enables flexible, nested lookups via direct pass-through of user-defined [jq](https://stedolan.github.io/jq) expressions.
  - Returns an empty map if the lookup fails, as well as a boolean result, enabling external conditional logic.
