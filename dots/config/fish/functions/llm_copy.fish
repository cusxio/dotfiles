# function llm_copy --description "Copies file contents to clipboard formatted as Markdown code blocks"
#     # Check if any arguments were provided.
#     if test (count $argv) -eq 0
#         echo "Usage: llm_copy <file1> <file2> ... <directory1>" >&2
#         echo "Copies file contents with filenames to the clipboard, formatted as Markdown code blocks." >&2
#         return 1
#     end
#
#     begin
#         for item in $argv
#             if test -f "$item"
#                 # This is a regular file.
#                 set filename (basename "$item")
#                 # Get the extension and pipe it to `string sub` to remove the leading dot.
#                 set extension (path extension "$item" | string sub -s 2)
#
#                 echo "## File: $filename"
#                 echo ----------------------------------------
#                 echo "```$extension"
#                 cat "$item"
#                 echo "```"
#                 echo ""
#                 echo ""
#
#             else if test -d "$item"
#                 # This is a directory.
#                 for file in (find "$item" -maxdepth 1 -type f | sort)
#                     set filename (basename "$file")
#                     set dirname (basename "$item")
#                     # Also remove the leading dot for files found in directories.
#                     set extension (path extension "$file" | string sub -s 2)
#
#                     echo "## File: $filename (from directory: $dirname)"
#                     echo ----------------------------------------
#                     echo "```$extension"
#                     cat "$file"
#                     echo "```"
#                     echo ""
#                     echo ""
#                 end
#
#             else
#                 # The argument is not a regular file or directory.
#                 echo "Warning: '$item' is not a regular file or directory. Skipping." >&2
#             end
#         end
#     end | pbcopy
#
#     echo "Copied content to clipboard, formatted as code blocks."
# end
# ~/.config/fish/functions/llm_copy.fish

# ~/.config/fish/functions/llm_copy.fish

function llm_copy --description "Recursively copies file contents to clipboard formatted as Markdown code blocks"
    # Check if any arguments were provided.
    if test (count $argv) -eq 0
        echo "Usage: llm_copy <file1> <file2> ... <directory1>" >&2
        echo "Copies file contents with filenames to the clipboard, formatted as Markdown code blocks." >&2
        return 1
    end

    # Store the current working directory to make paths relative.
    set -l current_dir (pwd)

    begin
        for item in $argv
            # If 'item' is a file, 'find' will just return that file.
            # If 'item' is a directory, 'find' will return all files within it recursively.
            for file in (find "$item" -type f | sort)
                # Determine the relative path of the file from the current directory.
                set -l relative_file_path (string replace -r "^$current_dir/" "" "$file")

                # Fallback if the path couldn't be made relative.
                if test "$relative_file_path" = "$file"
                    set relative_file_path "$file"
                end

                # Get the extension for the Markdown code fence.
                set extension (path extension "$file" | string sub -s 2)

                # Adjusted header to show the full relative path.
                echo "## File: $relative_file_path"
                echo ----------------------------------------
                echo "```$extension"
                cat "$file"
                echo "```"
                echo ""
                echo ""
            end

            if not test -e "$item"
                echo "Warning: '$item' does not exist. Skipping." >&2
            end
        end
    end | pbcopy

    echo "Copied content to clipboard, formatted as code blocks."
end
