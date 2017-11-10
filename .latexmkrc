#!/usr/bin/env perl

# http://qnighy.hatenablog.com/entry/2016/02/04/131601
$pdf_mode = 1;
$pdflatex = 'lualatex -synctex=1 -file-line-error -halt-on-error -interaction=nonstopmode %O %S';
$bibtex = 'pbibtex %O %B';

if ($^O eq 'darwin') {
    $pvc_view_file_via_temporary = 0;
    $pdf_previewer  = "open -ga skim";
} else {
    $pdf_previewer  = "evince";
}
