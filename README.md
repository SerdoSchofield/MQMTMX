This is a rough-and-tumble Readme, but here goes:

simply download these files to your computer then,

1) Place all .tmx files in a directory
2) open a console/terminal on a computer that has Perl
3) navigate to the contents of this folder (if you were to type "dir" you should see the "bin" and "lib" folders)
4) type in terminal
<blockquote>
  -$ perl -Ilib bin/scanAll.pl <the directory of the TMX files>
</blockquote>

EXAMPLE:
<blockquote>
  -$ perl -Ilib bin/scanAll.pl ../Desktop/"My TMX files are in this Folder"
</blockquote
5) if all goes well, the converted .txt files will be in a folder within your TMX directory called "Converted"!
