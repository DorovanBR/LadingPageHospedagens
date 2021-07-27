<%

  ' Simple functions to convert the first 256 characters 
  ' of the Windows character set from and to UTF-8.

  ' Written by Hans Kalle for Fisz
  ' http://www.fisz.nl

  'IsValidUTF8
  '  Tells if the string is valid UTF-8 encoded
  'Returns:
  '  true (valid UTF-8)
  '  false (invalid UTF-8 or not UTF-8 encoded string)
  function IsValidUTF8(s)
   dim i
   dim c
   dim n

   IsValidUTF8 = false
   i = 1
   do while i <= len(s)
     c = asc(mid(s,i,1))
     if c and &H80 then
       n = 1
       do while i + n < len(s)
         if (asc(mid(s,i+n,1)) and &HC0) <> &H80 then
           exit do
         end if
         n = n + 1
       loop
       select case n
       case 1
         exit function
       case 2
         if (c and &HE0) <> &HC0 then
           exit function
         end if
       case 3
         if (c and &HF0) <> &HE0 then
           exit function
         end if
       case 4
         if (c and &HF8) <> &HF0 then
           exit function
         end if
       case else
         exit function
       end select
       i = i + n
     else
       i = i + 1
     end if
   loop
   IsValidUTF8 = true 
  end function

  'DecodeUTF8
  '  Decodes a UTF-8 string to the Windows character set
  '  Non-convertable characters are replace by an upside
  '  down question mark.
  'Returns:
  '  A Windows string
  function DecodeUTF8(s)
   dim i
   dim c
   dim n

   i = 1
   do while i <= len(s)
     c = asc(mid(s,i,1))
     if c and &H80 then
       n = 1
       do while i + n < len(s)
         if (asc(mid(s,i+n,1)) and &HC0) <> &H80 then
           exit do
         end if
         n = n + 1
       loop
       if n = 2 and ((c and &HE0) = &HC0) then
         c = asc(mid(s,i+1,1)) + &H40 * (c and &H01)
       else
         c = 191 
       end if
       s = left(s,i-1) + chr(c) + mid(s,i+n)
     end if
     i = i + 1
   loop
   DecodeUTF8 = s 
  end function

  'EncodeUTF8
  '  Encodes a Windows string in UTF-8
  'Returns:
  '  A UTF-8 encoded string
  function EncodeUTF8(s)
   dim i
   dim c

   i = 1
   do while i <= len(s)
     c = asc(mid(s,i,1))
     if c >= &H80 then
       s = left(s,i-1) + chr(&HC2 + ((c and &H40) / &H40)) + chr(c and &HBF) + mid(s,i+1)
       i = i + 1
     end if
     i = i + 1
   loop
   EncodeUTF8 = s 
  end function
%>