summary := function(code_record)
    Print(
        "\n",
        "G is ", StructureDescription(code_record.g), "\n",
        "Stabiliser = ", StructureDescription(code_record.m), "\n",
        "Order G = ", Size(code_record.g), "\n",
        "Order Stabiliser = ", Size(code_record.m), "\n",
        "v = ", code_record.domainsize, "\n",
        "k = ", code_record.k, "\n",
        "Size of code = ", code_record.codesize, "\n",
        "Minimum distance = ", code_record.mindist, "\n", "\n");
end;

latex := function(code_record)
    # Prints code details in a latex pasteable format
    # Headings:
    # $X$ & $X_\gamma$ & $|\Gamma|$ & $v$ & $k$ & $\delta$ \\
    #
    Print(
        "\n",
        "$", StructureDescription(code_record.g), "$", "&",
        "$", StructureDescription(code_record.m), "$", "&",
        "$", code_record.codesize, "$", "&",
        "$", code_record.domainsize, "$", "&",
        "$", code_record.k, "$", "&",
        "$", code_record.mindist, "$", "&",
        "\\",
        "\n"
        );
end;

c1tex := function(dimV, dimU, epsilon, type)
    # Prints c1 details in a latex pasteable format
    # Headings:
    # $\dim(V)$ & $\dim(U)$ & $X$ & $X_\gamma$ & $|\Gamma|$ & $v$ & $k$ & $\delta$ \\
    #
    local code_record;
    if type = 'n' then
        code_record := NDCode(dimV, dimU, epsilon);
    elif type = 'p' then
        code_record := ParabolicCode(dimV, dimU, epsilon);
    else
        return Error("Code type must be 'n' or 'p'");
    fi;
    Print(
        "\n",
        "$", dimV, "$", "&",
        "$", dimU, "$", "&",
        "$", epsilon, "$", "&",
        "$", type, "$", "&",
        "$", StructureDescription(code_record.g), "$", "&",
        "$", StructureDescription(code_record.m), "$", "&",
        "$", code_record.codesize, "$", "&",
        "$", code_record.domainsize, "$", "&",
        "$", code_record.k, "$", "&",
        "$", code_record.mindist, "$", "&",
        "\\\\",
        "\n"
        );
end;
