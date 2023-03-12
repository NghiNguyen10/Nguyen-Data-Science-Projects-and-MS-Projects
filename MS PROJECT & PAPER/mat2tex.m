function mat2tex(A, fname, col_char)
[n, m]   = size(A);
fid       = fopen(fname,'w');

%
% Build matrix dependent strings and write to file
%
col_str   = char( col_char * ones(1, m) );
array_str = strcat('\begin{array}{', col_str, '}');

fprintf(fid,'\\begin{equation*}\n');
fprintf(fid,'\\left[\n');
fprintf(fid,'%s \n', array_str);

for r = 1:n
    row_str = int2str( A(r,1) );
    for c = 2:m
        row_str = [row_str ' & ' int2str( A(r,c) ) ];
    end
    if r < n
        row_str = [row_str, ' \\'];
    end
    fprintf(fid,'%s \n', row_str);
end

fprintf(fid,'\\end{array}\n');
fprintf(fid,'\\right]\n');
fprintf(fid,'\\end{equation*}\n');

fclose(fid);