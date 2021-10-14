<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/conexao.asp"-->
<!--#include file="helpers/helper_Charset.asp"-->
<!--#include file="helpers/helper_Base64.asp"-->
<!--#include file="helpers/helper_JSON.asp"-->
<!--#include file="helpers/helper_Debugger.asp"-->
<!--#include file="helpers/helper_ByteToString.asp"-->
<!--#include file="helpers/helper_FuncoesURL.asp"-->
<!--#include file="helpers/helper_FuncoesAPI.asp"-->
<%

	'+------------------------------------------------------------------------------+'
	'|-Projeto: SOS Hospedagens     				        	                    |'
	'|-Versão: 1.0									        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-API: Leadings da Landinpage       			        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Metodos da API:  							        	                    |'
	'|- (1) - Cadastro de Leadings  				        	                    |'
	'|- (2) - Alteração de Leadings 				        	                    |'
	'|- (3) - Exclusão de Leadings  				        	                    |'
	'|- (4) - Consulta de Leadings  				        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Funções da API:								        	                    |'
	'+------------------------------------------------------------------------------+'

	'Declaração das Variaveis'

		Funcao = cInt(Request("Funcao"))

	'Metodos da API'

		Select Case cInt(Funcao)

            Case 1

                'Declara as Variaveis

                    CpfCnpj = Request("CpfCnpj")
                    Nome = EncodeUTF8(Request("Nome"))
                    Email = Request("Email")
                    Telefone = Request("Telefone")
                    Cep = Request("Cep")
                    Bairro = EncodeUTF8(Request("Bairro"))
                    Cidade = EncodeUTF8(Request("Cidade"))
                    UF = Request("UF")
                    Logradouro = EncodeUTF8(Request("Logradouro"))
                    Numero = Request("Numero")
                    IP = Request("IP")
                    NavegouSite = cInt(Request("NavegouSite"))
                    NavegouContato = cInt(Request("NavegouContato"))
                    NavegouHospedagem = cInt(Request("NavegouHospedagem"))
                    
                    colunas_sql = ""
                    campos_sql = ""

                'Verifica se foi enviado o IP

                    if trim(IP) = "" then

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O IP do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                'Estrutura as colunas e valores do SQL

                    if trim(CpfCnpj) <> "" then
                        colunas_sql = colunas_sql & "cpf_cnpj, "
                        campos_sql = campos_sql & "'" & CpfCnpj & "', "
                    end if

                    if trim(Nome) <> "" then
                        colunas_sql = colunas_sql & "nome, "
                        campos_sql = campos_sql & "'" & Nome & "', "
                    end if

                    if trim(Email) <> "" then
                        colunas_sql = colunas_sql & "email, "
                        campos_sql = campos_sql & "'" & Email & "', "
                    end if

                    if trim(Telefone) <> "" then
                        colunas_sql = colunas_sql & "telefone, "
                        campos_sql = campos_sql & "'" & Telefone & "', "
                    end if

                    if trim(Cep) <> "" then
                        colunas_sql = colunas_sql & "cep, "
                        campos_sql = campos_sql & "'" & Cep & "', "
                    end if

                    if trim(Bairro) <> "" then
                        colunas_sql = colunas_sql & "bairro, "
                        campos_sql = campos_sql & "'" & Bairro & "', "
                    end if

                    if trim(Cidade) <> "" then
                        colunas_sql = colunas_sql & "cidade, "
                        campos_sql = campos_sql & "'" & Cidade & "', "
                    end if

                    if trim(UF) <> "" then
                        colunas_sql = colunas_sql & "uf, "
                        campos_sql = campos_sql & "'" & UF & "', "
                    end if

                    if trim(Logradouro) <> "" then
                        colunas_sql = colunas_sql & "logradouro, "
                        campos_sql = campos_sql & "'" & Logradouro & "', "
                    end if

                    if trim(Numero) <> "" then
                        colunas_sql = colunas_sql & "numero, "
                        campos_sql = campos_sql & "'" & Numero & "', "
                    end if

                    if trim(IP) <> "" then
                        colunas_sql = colunas_sql & "ip, "
                        campos_sql = campos_sql & "'" & IP & "', "
                    end if

                    if cInt(NavegouSite) <> 0 and trim(NavegouSite) <> "" then
                        colunas_sql = colunas_sql & "navegou_site, "
                        campos_sql = campos_sql & "" & NavegouSite & ", "
                    end if

                    if cInt(NavegouContato) <> 0 and trim(NavegouContato) <> "" then
                        colunas_sql = colunas_sql & "navegou_contato, "
                        campos_sql = campos_sql & "" & NavegouContato & ", "
                    end if

                    if cInt(NavegouHospedagem) <> 0 and trim(NavegouHospedagem) <> "" then
                        colunas_sql = colunas_sql & "navegou_hospedagem, "
                        campos_sql = campos_sql & "" & NavegouHospedagem & ", "
                    end if

                'Insere os Campos de Controle

                    DataCadastro = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                    colunas_sql = colunas_sql & "data_cadastro, "
                    campos_sql = campos_sql & "'" & DataCadastro & "', "

                    HorarioCadastro = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                    colunas_sql = colunas_sql & "horario_cadastro, "
                    campos_sql = campos_sql & "'" & HorarioCadastro & "', "

                    CodSituacao = 1
                    colunas_sql = colunas_sql & "cod_situacao"
                    campos_sql = campos_sql & "" & CodSituacao & ""

                    ' call debuga(colunas_sql, false)
                    ' call debuga(campos_sql, true)

                'Estrutura a String SQL

                    string_sql = "insert into leadings ("&colunas_sql&") VALUES ("&campos_sql&")"

                    ' call debuga(string_sql, true)

                'Realiza a Inserção

                    set insereLeading = ConexaoBD.Execute(string_sql)

                'Estrutura a String SQL

                    string_sql = "select codigo from leadings where ip = '"&IP&"' and data_cadastro = '"&DataCadastro&"' and horario_cadastro = '"&HorarioCadastro&"' and cod_situacao = " & CodSituacao

                'Consulta o Ultimo Registro Lançado

                    set consultaLeading = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Leading Cadastrado com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                'Estrutura o Retorno Customizado

                    DadosRetorno = "{"
                    DadosRetorno = DadosRetorno & """Leading"": " & consultaLeading("codigo")
                    DadosRetorno = DadosRetorno & "}"

                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, True, DadosRetorno)

            Case 2

                'Declara as Variaveis

                    Codigo = Request("Codigo")
                    CpfCnpj = Request("CpfCnpj")
                    Nome = EncodeUTF8(Request("Nome"))
                    Email = Request("Email")
                    Telefone = Request("Telefone")
                    Cep = Request("Cep")
                    Bairro = EncodeUTF8(Request("Bairro"))
                    Cidade = EncodeUTF8(Request("Cidade"))
                    UF = Request("UF")
                    Logradouro = EncodeUTF8(Request("Logradouro"))
                    Numero = Request("Numero")
                    IP = Request("IP")
                    NavegouSite = cInt(Request("NavegouSite"))
                    NavegouContato = cInt(Request("NavegouContato"))
                    NavegouHospedagem = cInt(Request("NavegouHospedagem"))

                    campos_sql = ""

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                'Estrutura as colunas e valores do SQL

                    if trim(CpfCnpj) <> "" then
                        campos_sql = campos_sql & "cpf_cnpj = '" & CpfCnpj & "', "
                    end if

                    if trim(Nome) <> "" then
                        campos_sql = campos_sql & "nome = '" & Nome & "', "
                    end if

                    if trim(Email) <> "" then
                        campos_sql = campos_sql & "email = '" & Email & "', "
                    end if

                    if trim(Telefone) <> "" then
                        campos_sql = campos_sql & "telefone = '" & Telefone & "', "
                    end if

                    if trim(Cep) <> "" then
                        campos_sql = campos_sql & "cep = '" & Cep & "', "
                    end if

                    if trim(Bairro) <> "" then
                        campos_sql = campos_sql & "bairro = '" & Bairro & "', "
                    end if

                    if trim(Cidade) <> "" then
                        campos_sql = campos_sql & "cidade = '" & Cidade & "', "
                    end if

                    if trim(UF) <> "" then
                        campos_sql = campos_sql & "uf = '" & UF & "', "
                    end if

                    if trim(Logradouro) <> "" then
                        campos_sql = campos_sql & "logradouro = '" & Logradouro & "', "
                    end if

                    if trim(Numero) <> "" then
                        campos_sql = campos_sql & "numero = '" & Numero & "', "
                    end if

                    if trim(IP) <> "" then
                        campos_sql = campos_sql & "ip = '" & IP & "', "
                    end if

                    if cInt(NavegouSite) <> 0 and trim(NavegouSite) <> "" then
                        campos_sql = campos_sql & "navegou_site = " & NavegouSite & ", "
                    end if

                    if cInt(NavegouContato) <> 0 and trim(NavegouContato) <> "" then
                        campos_sql = campos_sql & "navegou_contato = " & NavegouContato & ", "
                    end if

                    if cInt(NavegouHospedagem) <> 0 and trim(NavegouHospedagem) <> "" then
                        campos_sql = campos_sql & "navegou_hospedagem = " & NavegouHospedagem & ", "
                    end if

                'Insere os Campos de Controle

                    DataAtualizacao = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                    campos_sql = campos_sql & "data_atualizacao = '" & DataAtualizacao & "', "

                    HorarioAtualizacao = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                    campos_sql = campos_sql & "horario_atualizacao = '" & HorarioAtualizacao & "'"

                    ' call debuga(colunas_sql, false)
                    ' call debuga(campos_sql, true)

                'Estrutura a String SQL

                    string_sql = "update leadings set " & campos_sql & " where codigo = " & Codigo

                    ' call debuga(string_sql, true)

                'Realiza a Alteração

                    set alteraLeading = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Leading Atualizado com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

            Case 3

                'Declara as Variaveis

                    Codigo = Request("Codigo")

                    campos_sql = ""

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                'Verifica se o Registro já foi excluido

                    string_sql = "select count(codigo) as Total from leadings where cod_situacao = 2 and codigo = " & Codigo

                    set checaRegistro = ConexaoBD.Execute(string_sql)

                    if cInt(checaRegistro("Total")) >= 1 then

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Eita"
                            MensagemTexto = "Esse registro já foi excluido, verifique e tente novamente"
                            MensagemTipo = "warning"
                            StatusRequisicao = 400
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    else

                        'Insere os Campos de Controle

                            DataAtualizacao = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                            campos_sql = campos_sql & "data_atualizacao = '" & DataAtualizacao & "', "

                            HorarioAtualizacao = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                            campos_sql = campos_sql & "horario_atualizacao = '" & HorarioAtualizacao & "', "

                            CodSituacao = 2
                            campos_sql = campos_sql & "cod_situacao = " & CodSituacao & ""

                        'Estrutura a String SQL

                            string_sql = "update leadings set " & campos_sql & " where codigo = " & Codigo

                            ' call debuga(string_sql, true)

                        'Realiza a Exclusão

                            set excluiLeading = ConexaoBD.Execute(string_sql)

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Sucesso"
                            MensagemTexto = "Leading Excluído com sucesso."
                            MensagemTipo = "success"
                            StatusRequisicao = 200
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

            Case 4

                'Declara as Variaveis

                    Codigo = Request("Codigo")

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        string_sql = "select * from leadings where cod_situacao = 1"
                    else
                        string_sql = "select * from leadings where cod_situacao = 1 and codigo = " & Codigo
                    end if

                'Verifica se o Registro já foi excluido

                    set consultaLeadings = ConexaoBD.Execute(string_sql)

                'Cria a Estrutura dos Registros

                    EstruturaLeadings = ""

                'Faz um laço de repetição para listar os dados na tela

                    while not consultaLeadings.eof

                        CpfCnpj = consultaLeadings("cpf_cnpj")
                        Nome = consultaLeadings("nome")
                        Email = consultaLeadings("email")
                        Telefone = consultaLeadings("telefone")
                        Cep = consultaLeadings("cep")
                        Bairro = consultaLeadings("bairro")
                        Cidade = consultaLeadings("cidade")
                        UF = consultaLeadings("uf")
                        Logradouro = consultaLeadings("logradouro")
                        Numero = consultaLeadings("numero")
                        IP = consultaLeadings("ip")
                        NavegouSite = consultaLeadings("navegou_site")
                        NavegouContato = consultaLeadings("navegou_contato")
                        NavegouHospedagem = consultaLeadings("navegou_hospedagem")
                        DataCadastro = consultaLeadings("data_cadastro")
                        HorarioCadastro = consultaLeadings("horario_cadastro")
                        DataAtualizacao = consultaLeadings("data_atualizacao")
                        HorarioAtualizacao = consultaLeadings("horario_atualizacao")

                        EstruturaLeadings = EstruturaLeadings & "{"
                        EstruturaLeadings = EstruturaLeadings & """CpfCnpj"": """ & CpfCnpj & ""","
                        EstruturaLeadings = EstruturaLeadings & """Nome"": """ & DecodeUTF8(Nome) & ""","
                        EstruturaLeadings = EstruturaLeadings & """Email"": """ & Email & ""","
                        EstruturaLeadings = EstruturaLeadings & """Telefone"": """ & Telefone & ""","
                        EstruturaLeadings = EstruturaLeadings & """Cep"": """ & Cep & ""","
                        EstruturaLeadings = EstruturaLeadings & """Bairro"": """ & DecodeUTF8(Bairro) & ""","
                        EstruturaLeadings = EstruturaLeadings & """Cidade"": """ & DecodeUTF8(Cidade) & ""","
                        EstruturaLeadings = EstruturaLeadings & """UF"": """ & UF & ""","
                        EstruturaLeadings = EstruturaLeadings & """Logradouro"": """ & DecodeUTF8(Logradouro) & ""","
                        EstruturaLeadings = EstruturaLeadings & """Numero"": """ & Numero & ""","
                        EstruturaLeadings = EstruturaLeadings & """IP"": """ & IP & ""","
                        EstruturaLeadings = EstruturaLeadings & """NavegouSite"": """ & NavegouSite & ""","
                        EstruturaLeadings = EstruturaLeadings & """NavegouContato"": """ & NavegouContato & ""","
                        EstruturaLeadings = EstruturaLeadings & """NavegouHospedagem"": """ & NavegouHospedagem & ""","
                        EstruturaLeadings = EstruturaLeadings & """DataCadastro"": """ & DataCadastro & ""","
                        EstruturaLeadings = EstruturaLeadings & """HorarioCadastro"": """ & HorarioCadastro & ""","
                        EstruturaLeadings = EstruturaLeadings & """DataAtualizacao"": """ & DataAtualizacao & ""","
                        EstruturaLeadings = EstruturaLeadings & """HorarioAtualizacao"": """ & HorarioAtualizacao & """"
                        EstruturaLeadings = EstruturaLeadings & "}"

                        consultaLeadings.movenext
                    wend

                'Ajusta a Estrutura dos Registros JSON

                    EstruturaLeadings = replace(EstruturaLeadings, "}{", "},{")

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Leadings carregados com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    DadosRetorno = "{"
                    DadosRetorno = DadosRetorno & """Leadings"": [" & EstruturaLeadings & "]"
                    DadosRetorno = DadosRetorno & "}"
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, True, DadosRetorno)

        End Select

%>