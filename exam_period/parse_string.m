function parsed_str = parse_string(str, symbols, string_reps)

    parsed_str = str;

    for i = 1:length(symbols)
       
        parsed_str = strrep(parsed_str, string(symbols(i)), string_reps(i));
        
    end
    
    parsed_str = strrep(parsed_str, '\', '\\');

end