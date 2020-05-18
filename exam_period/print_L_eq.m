f = fopen("latex.txt", "w");
if f == -1
    error("Failed to open file!")
end

symbols = {
    Lag_q,
    Lag_qdq,
    Lag_dq,
    Lag_dqdq
};

symbols_names = [
    "\frac{\partial\mathcal{L}}{\partial q}",
    "Lag_qdq",
    "Lag_dq",
    "\frac{\partial^2\mathcal{L}}{\partial q^2}"
];

diff_vars = {    
    dx,
    dtheta1,
    dtheta2
};

string_reps = ["\dot{x}", "\dot{\theta}_1", "\dot{\theta}_2"];

fprintf(f, "\\begin{align*}\n");

for i = length(symbols)-1
    
    symbol = symbols{i};
    symbol_name = symbols_names(i);

    expr = parse_string(symbol_name + "&=" + latex(symbol) + "\\", diff_vars, string_reps);
    fprintf(f, expr + "\n");
    
end

fprintf(f, "\\end{align*}");

fclose(f);