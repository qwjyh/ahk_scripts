# Create registry key to remap scan codes
# write binary file to "Scancode Map.bin.example"

# how to write
# 1. 00 00 00 00 : Header(Version)
# 2. 00 00 00 00 : Header(Flags)
# 3. Number of Entryies(like "00000001")
# 4. remapping entries
# FROM TO (each 2bytes)
# 5. 00 00 00 00 : Null terminator
# Be aware of endians; each parameters must be little endians
# i.e. reverse each bytes
# e.g. 006b003a -> 3a 00 6b 00
# see https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/keyboard-and-mouse-class-drivers#scan-code-mapper-for-keyboards,
# https://tepp91.github.io/contents/misc/remap-keyboard-with-scancode-map.html
# for detail and example

# need admin

# format file to hex list
$binary =  (Get-Content '.\Scancode Map.bin.example').Split(" ") -replace "`n", "" | ForEach-Object {"0x$_"}
# Create
# -Force => overwrite
# -Confirm => ask user
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout' -Name 'Scancode Map' -PropertyType 'Binary' -Value $binary -Force -Confirm