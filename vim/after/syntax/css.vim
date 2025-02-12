setlocal wrap
syn region cssPseudoClassFn contained matchgroup=cssFunctionName start="\<\(where\|has|\not\)(" end=")" contains=cssStringQ,cssStringQQ,cssTagName,cssAttributeSelector,cssClassName,cssIdentifier
syn keyword cssProp contained inset row-gap column-gap place-items place-content place-self paint-order rotate scale translate margin-inline margin-block padding-inline padding-block

