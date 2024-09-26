# Noordhof book downloader

This is a proof-of-concept script for downloading the Noordhof
books as PDF files.

## Requirements

- Access to the book you want to download in the noordhof online
    learning environment
- bash
- wget
- Something that can merge multiple PDF files into one

## Steps

- Open the book that you waant to download in the online
    learning environment

- Open the browser console

- Go to "Network"

- Use the search bar to search for "pdf"

- Find a url that looks like
    `https://pdfsplitter.blob.core.windows.net/pdf/production/split-books/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX_XX_XX.pdf`

- Edit the `noordhof-downloader.sh` script and change the `baseurl`
    variable at the start of the file
    to be the URL that you found, WITHOUT the last two numbers and the `.pdf` extension.
    So the entire line in the script should look like
    `baseurl="https://pdfsplitter.blob.core.windows.net/pdf/production/split-books/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX_"`

- Make a directory called `capt`

- Run the script and wait for it to finish

If all goes well, you should now have the entire book,
as a collection of split PDF files,
inside the `capt` directory

## Merging the PDF files

You will probably want to merge the split PDF files into one PDF file.
You can use whatever tool you like for this, but my approach is as follows:

```bash
pdfunite capt/* book.pdf  # Merge the files
qpdf --linearize book.pdf --replace-input  # Fix errors
exiftool -All= book.pdf  # Remove metadata
qpdf --linearize book.pdf --replace-input  # Really remove metadata
```

Note that some of the PDF files that were downloaded will be empty.
This does not mean data was lost,
you can simply delete/ignore these empty files.

## Notes

The script downloads files from a publicly accessible endpoint.
So you do not need have access to the learning environment
to use it,
as long as you have a friend who does have access and can get
the `pdfsplitter.blob.core.windows.net` URL for you.

