{...}: {
  mkArrIf = predicate: value:
    if predicate
    then value
    else [];
}
