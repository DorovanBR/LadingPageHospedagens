<%

	'Função para pegar o ultimo dia do Mês'

		Function EndDayOfMonth(dDate)
		    EndDayOfMonth = Day(DateAdd("m", 1, dDate - Day(dDate) + 1) - 1)
		End Function
	
	'Função para Adicionar data'

		Function AdicionaData(Data, Valor, Dia, Periodo)
			Data = DateAdd(Periodo,cInt(Valor),Data)
			TotalDiasMes = EndDayOfMonth(Data)
			Data = replace(Data, "/", "-")
			Data = split(Data, "-")
			if cInt(Data(0)) > cInt(TotalDiasMes) then
				AdicionaData = Data(2) & "-" & Data(1) & "-" & TotalDiasMes
			elseif cInt(Dia) > cInt(Data(0)) and cInt(Dia) <= cInt(TotalDiasMes) then
				AdicionaData = Data(2) & "-" & Data(1) & "-" & Dia
			else
				AdicionaData = Data(2) & "-" & Data(1) & "-" & Data(0)
			End if
		End Function

	'Função para Gerar o Codigo Hash do Registro'

		Function GeraHash(tipo, parcelas)
			chave = GerarChave(6)
			GeraHash = tipo & "-" & chave & "-" & parcelas 
		End Function

	'Função para Alterar o Codigo Hash sem modificar a chave do Registro'

		Function AtualizaHash(hash, parcelas)
			hash = split(hash, "-")
			hash(2) = parcelas
			AtualizaHash = hash(0) & "-" & hash(1) & "-" & hash(2)
		End Function

	'Função para Gerar a Chave Unica'

		Function GerarChave(caracteres)
			ASCII_MA_Min = 65 
			ASCII_MA_Max = 90
			ASCII_MI_Min = 97 
			ASCII_MI_Max = 122
			Randomize
			Do While Len(Chave) < cInt(caracteres)
			MA_x_MI = Int(1*(Rnd+1))
			Select Case cInt(MA_x_MI)
				Case 1
					Num = Chr(Int((ASCII_MA_Max - ASCII_MA_Min)) * Rnd + ASCII_MA_Min)
				Case 2
					Num = Chr(Int((ASCII_MI_Max - ASCII_MI_Min)) * Rnd + ASCII_MI_Min)
			End Select
			Chave = Chave + Num
			Loop 
			GerarChave = Chave
		End Function

	'Função para Codificar Base64'

		Function Base64Encode(sText)
		    Dim oXML, oNode

		    Set oXML = CreateObject("Msxml2.DOMDocument.3.0")
		    Set oNode = oXML.CreateElement("base64")
		    oNode.dataType = "bin.base64"
		    oNode.nodeTypedValue =Stream_StringToBinary(sText)
		    Base64Encode = oNode.text
		    Set oNode = Nothing
		    Set oXML = Nothing
		End Function

	'Função para Decodificar Base64'

		Function Base64Decode(ByVal vCode)
		    Dim oXML, oNode

		    Set oXML = CreateObject("Msxml2.DOMDocument.3.0")
		    Set oNode = oXML.CreateElement("base64")
		    oNode.dataType = "bin.base64"
		    oNode.text = vCode
		    Base64Decode = Stream_BinaryToString(oNode.nodeTypedValue)
		    Set oNode = Nothing
		    Set oXML = Nothing
		End Function

	'Stream_StringToBinary Function
	'2003 Antonin Foller, http://www.motobit.com
	'Text - string parameter To convert To binary data

		Function Stream_StringToBinary(Text)
		  Const adTypeText = 2
		  Const adTypeBinary = 1

		  'Create Stream object
		  Dim BinaryStream 'As New Stream
		  Set BinaryStream = CreateObject("ADODB.Stream")

		  'Specify stream type - we want To save text/string data.
		  BinaryStream.Type = adTypeText

		  'Specify charset For the source text (unicode) data.
		  BinaryStream.CharSet = "us-ascii"

		  'Open the stream And write text/string data To the object
		  BinaryStream.Open
		  BinaryStream.WriteText Text

		  'Change stream type To binary
		  BinaryStream.Position = 0
		  BinaryStream.Type = adTypeBinary

		  'Ignore first two bytes - sign of
		  BinaryStream.Position = 0

		  'Open the stream And get binary data from the object
		  Stream_StringToBinary = BinaryStream.Read

		  Set BinaryStream = Nothing
		End Function

	'Stream_BinaryToString Function
	'2003 Antonin Foller, http://www.motobit.com
	'Binary - VT_UI1 | VT_ARRAY data To convert To a string
	
		Function Stream_BinaryToString(Binary)
		  Const adTypeText = 2
		  Const adTypeBinary = 1

		  'Create Stream object
		  Dim BinaryStream 'As New Stream
		  Set BinaryStream = CreateObject("ADODB.Stream")

		  'Specify stream type - we want To save binary data.
		  BinaryStream.Type = adTypeBinary

		  'Open the stream And write binary data To the object
		  BinaryStream.Open
		  BinaryStream.Write Binary

		  'Change stream type To text/string
		  BinaryStream.Position = 0
		  BinaryStream.Type = adTypeText

		  'Specify charset For the output text (unicode) data.
		  BinaryStream.CharSet = "us-ascii"

		  'Open the stream And get text/string data from the object
		  Stream_BinaryToString = BinaryStream.ReadText
		  Set BinaryStream = Nothing
		End Function

%>