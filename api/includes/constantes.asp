<%

	'Constantes do Banco de Dados'

		adodbDriver = "driver={MySQL ODBC 5.3 ANSI Driver}"
		adodbServer = "server=127.0.0.1"
		adodbPort = "port=3306"
		adodbDatabase = "database=db_cliente_soshospedagens"
		adodbCharset = "charset=utf8"
		adodbOption = 3
		adodbUser = "user=soshospedagens_admin"
		adodbPass = "password=@Sos123!"

	'Constantes de URLS'

		UploadImagemPerfil_maxSize = 524288000
		UploadImagemPerfil_useUniqueNames = True
		UploadImagemPerfil_UseVirtualDir = False
		UploadImagemPerfil_src = "../assets/imagens/"

	'Constantes de Variaveis Globais'

		CVG_ALL_HTTP = Request.ServerVariables("ALL_HTTP")
		CVG_ALL_RAW = Request.ServerVariables("ALL_RAW")
		CVG_APPL_MD_PATH = Request.ServerVariables("APPL_MD_PATH")
		CVG_APPL_PHYSICAL_PATH = Request.ServerVariables("APPL_PHYSICAL_PATH")
		CVG_AUTH_PASSWORD = Request.ServerVariables("AUTH_PASSWORD")
		CVG_AUTH_TYPE = Request.ServerVariables("AUTH_TYPE")
		CVG_AUTH_USER = Request.ServerVariables("AUTH_USER")
		CVG_CERT_COOKIE = Request.ServerVariables("CERT_COOKIE")
		CVG_CERT_FLAGS = Request.ServerVariables("CERT_FLAGS")
		CVG_CERT_ISSUER = Request.ServerVariables("CERT_ISSUER")
		CVG_CERT_KEYSIZE = Request.ServerVariables("CERT_KEYSIZE")
		CVG_CERT_SECRETKEYSIZE = Request.ServerVariables("CERT_SECRETKEYSIZE")
		CVG_CERT_SERIALNUMBER = Request.ServerVariables("CERT_SERIALNUMBER")
		CVG_CERT_SERVER_ISSUER = Request.ServerVariables("CERT_SERVER_ISSUER")
		CVG_CERT_SERVER_SUBJECT = Request.ServerVariables("CERT_SERVER_SUBJECT")
		CVG_CERT_SUBJECT = Request.ServerVariables("CERT_SUBJECT")
		CVG_CONTENT_LENGTH = Request.ServerVariables("CONTENT_LENGTH")
		CVG_CONTENT_TYPE = Request.ServerVariables("CONTENT_TYPE")
		CVG_GATEWAY_INTERFACE = Request.ServerVariables("GATEWAY_INTERFACE")
		CVG_HTTP_ACCEPT = Request.ServerVariables("HTTP_ACCEPT")
		CVG_HTTP_ACCEPT_CHARSET = Request.ServerVariables("HTTP_ACCEPT_CHARSET")
		CVG_HTTP_ACCEPT_ENCODING = Request.ServerVariables("HTTP_ACCEPT_ENCODING")
		CVG_HTTP_ACCEPT_LANGUAGE = Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")
		CVG_HTTP_ACCEPT_RANGES = Request.ServerVariables("HTTP_ACCEPT_RANGES")
		CVG_HTTP_ACCESS_CONTROL_ALLOW_CREDENTIALS = Request.ServerVariables("HTTP_ACCESS_CONTROL_ALLOW_CREDENTIALS")
		CVG_HTTP_ACCESS_CONTROL_ALLOW_HEADERS = Request.ServerVariables("HTTP_ACCESS_CONTROL_ALLOW_HEADERS")
		CVG_HTTP_ACCESS_CONTROL_ALLOW_METHODS = Request.ServerVariables("HTTP_ACCESS_CONTROL_ALLOW_METHODS")
		CVG_HTTP_ACCESS_CONTROL_ALLOW_ORIGIN = Request.ServerVariables("HTTP_ACCESS_CONTROL_ALLOW_ORIGIN")
		CVG_HTTP_ACCESS_CONTROL_EXPOSE_HEADERS = Request.ServerVariables("HTTP_ACCESS_CONTROL_EXPOSE_HEADERS")
		CVG_HTTP_ACCESS_CONTROL_MAX_AGE = Request.ServerVariables("HTTP_ACCESS_CONTROL_MAX_AGE")
		CVG_HTTP_ACCESS_CONTROL_REQUEST_HEADERS = Request.ServerVariables("HTTP_ACCESS_CONTROL_REQUEST_HEADERS")
		CVG_HTTP_ACCESS_CONTROL_REQUEST_METHOD = Request.ServerVariables("HTTP_ACCESS_CONTROL_REQUEST_METHOD")
		CVG_HTTP_AGE = Request.ServerVariables("HTTP_AGE")
		CVG_HTTP_ALLOW = Request.ServerVariables("HTTP_ALLOW")
		CVG_HTTP_AUTHORITY = Request.ServerVariables("HTTP_AUTHORITY")
		CVG_HTTP_AUTHORIZATION = Request.ServerVariables("HTTP_AUTHORIZATION")
		CVG_HTTP_CACHE_CONTROL = Request.ServerVariables("HTTP_CACHE_CONTROL")
		CVG_HTTP_CONNECTION = Request.ServerVariables("HTTP_CONNECTION")
		CVG_HTTP_CONTENT_DISPOSITION = Request.ServerVariables("HTTP_CONTENT_DISPOSITION")
		CVG_HTTP_CONTENT_ENCODING = Request.ServerVariables("HTTP_CONTENT_ENCODING")
		CVG_HTTP_CONTENT_LANGUAGE = Request.ServerVariables("HTTP_CONTENT_LANGUAGE")
		CVG_HTTP_CONTENT_LENGTH = Request.ServerVariables("HTTP_CONTENT_LENGTH")
		CVG_HTTP_CONTENT_LOCATION = Request.ServerVariables("HTTP_CONTENT_LOCATION")
		CVG_HTTP_CONTENT_MD5 = Request.ServerVariables("HTTP_CONTENT_MD5")
		CVG_HTTP_CONTENT_RANGE = Request.ServerVariables("HTTP_CONTENT_RANGE")
		CVG_HTTP_CONTENT_SECURITY_POLICY = Request.ServerVariables("HTTP_CONTENT_SECURITY_POLICY")
		CVG_HTTP_CONTENT_SECURITY_POLICY_REPORT_ONLY = Request.ServerVariables("HTTP_CONTENT_SECURITY_POLICY_REPORT_ONLY")
		CVG_HTTP_CONTENT_TYPE = Request.ServerVariables("HTTP_CONTENT_TYPE")
		CVG_HTTP_COOKIE = Request.ServerVariables("HTTP_COOKIE")
		CVG_HTTP_CORRELATION_CONTEXT = Request.ServerVariables("HTTP_CORRELATION_CONTEXT")
		CVG_HTTP_DATE = Request.ServerVariables("HTTP_DATE")
		CVG_HTTP_DNT = Request.ServerVariables("HTTP_DNT")
		CVG_HTTP_ETAG = Request.ServerVariables("HTTP_ETAG")
		CVG_HTTP_EXPECT = Request.ServerVariables("HTTP_EXPECT")
		CVG_HTTP_EXPIRES = Request.ServerVariables("HTTP_EXPIRES")
		CVG_HTTP_FROM = Request.ServerVariables("HTTP_FROM")
		CVG_HTTP_HOST = Request.ServerVariables("HTTP_HOST")
		CVG_HTTP_IF_MATCH = Request.ServerVariables("HTTP_IF_MATCH")
		CVG_HTTP_IF_MODIFIED_SINCE = Request.ServerVariables("HTTP_IF_MODIFIED_SINCE")
		CVG_HTTP_IF_NONE_MATCH = Request.ServerVariables("HTTP_IF_NONE_MATCH")
		CVG_HTTP_IF_RANGE = Request.ServerVariables("HTTP_IF_RANGE")
		CVG_HTTP_IF_UNMODIFIED_SINCE = Request.ServerVariables("HTTP_IF_UNMODIFIED_SINCE")
		CVG_HTTP_KEEP_ALIVE = Request.ServerVariables("HTTP_KEEP_ALIVE")
		CVG_HTTP_LAST_MODIFIED = Request.ServerVariables("HTTP_LAST_MODIFIED")
		CVG_HTTP_LOCATION = Request.ServerVariables("HTTP_LOCATION")
		CVG_HTTP_MAX_FORWARDS = Request.ServerVariables("HTTP_MAX_FORWARDS")
		CVG_HTTP_METHOD = Request.ServerVariables("HTTP_METHOD")
		CVG_HTTP_ORIGIN = Request.ServerVariables("HTTP_ORIGIN")
		CVG_HTTP_PATH = Request.ServerVariables("HTTP_PATH")
		CVG_HTTP_PRAGMA = Request.ServerVariables("HTTP_PRAGMA")
		CVG_HTTP_PROXY_AUTHENTICATE = Request.ServerVariables("HTTP_PROXY_AUTHENTICATE")
		CVG_HTTP_PROXY_AUTHORIZATION = Request.ServerVariables("HTTP_PROXY_AUTHORIZATION")
		CVG_HTTP_RANGE = Request.ServerVariables("HTTP_RANGE")
		CVG_HTTP_REFERER = Request.ServerVariables("HTTP_REFERER")
		CVG_HTTP_REQUEST_ID = Request.ServerVariables("HTTP_REQUEST_ID")
		CVG_HTTP_RETRY_AFTER = Request.ServerVariables("HTTP_RETRY_AFTER")
		CVG_HTTP_SCHEME = Request.ServerVariables("HTTP_SCHEME")
		CVG_HTTP_SEC_WEBSOCKET_ACCEPT = Request.ServerVariables("HTTP_SEC_WEBSOCKET_ACCEPT")
		CVG_HTTP_SEC_WEBSOCKET_KEY = Request.ServerVariables("HTTP_SEC_WEBSOCKET_KEY")
		CVG_HTTP_SEC_WEBSOCKET_PROTOCOL = Request.ServerVariables("HTTP_SEC_WEBSOCKET_PROTOCOL")
		CVG_HTTP_SEC_WEBSOCKET_VERSION = Request.ServerVariables("HTTP_SEC_WEBSOCKET_VERSION")
		CVG_HTTP_SERVER = Request.ServerVariables("HTTP_SERVER")
		CVG_HTTP_SETCOOKIE = Request.ServerVariables("HTTP_SETCOOKIE")
		CVG_HTTP_STATUS = Request.ServerVariables("HTTP_STATUS")
		CVG_HTTP_STRICT_TRANSPORT_SECURITY = Request.ServerVariables("HTTP_STRICT_TRANSPORT_SECURITY")
		CVG_HTTP_TE = Request.ServerVariables("HTTP_TE")
		CVG_HTTP_TRACE_PARENT = Request.ServerVariables("HTTP_TRACE_PARENT")
		CVG_HTTP_TRACE_STATE = Request.ServerVariables("HTTP_TRACE_STATE")
		CVG_HTTP_TRAILER = Request.ServerVariables("HTTP_TRAILER")
		CVG_HTTP_TRANSFER_ENCODING = Request.ServerVariables("HTTP_TRANSFER_ENCODING")
		CVG_HTTP_TRANSLATE = Request.ServerVariables("HTTP_TRANSLATE")
		CVG_HTTP_UPGRADE = Request.ServerVariables("HTTP_UPGRADE")
		CVG_HTTP_UPGRADE_INSECURE_REQUESTS = Request.ServerVariables("HTTP_UPGRADE_INSECURE_REQUESTS")
		CVG_HTTP_USER_AGENT = Request.ServerVariables("HTTP_USER_AGENT")
		CVG_HTTP_VARY = Request.ServerVariables("HTTP_VARY")
		CVG_HTTP_VIA = Request.ServerVariables("HTTP_VIA")
		CVG_HTTP_WARNING = Request.ServerVariables("HTTP_WARNING")
		CVG_HTTP_WEB_SOCKET_SUB_PROTOCOLS = Request.ServerVariables("HTTP_WEB_SOCKET_SUB_PROTOCOLS")
		CVG_HTTP_WWW_AUTHENTICATE = Request.ServerVariables("HTTP_WWW_AUTHENTICATE")
		CVG_HTTP_X_FRAME_OPTIONS = Request.ServerVariables("HTTP_X_FRAME_OPTIONS")
		CVG_HTTPS = Request.ServerVariables("HTTPS")
		CVG_HTTPS_KEYSIZE = Request.ServerVariables("HTTPS_KEYSIZE")
		CVG_HTTPS_SECRETKEYSIZE = Request.ServerVariables("HTTPS_SECRETKEYSIZE")
		CVG_HTTPS_SERVER_ISSUER = Request.ServerVariables("HTTPS_SERVER_ISSUER")
		CVG_HTTPS_SERVER_SUBJECT = Request.ServerVariables("HTTPS_SERVER_SUBJECT")
		CVG_INSTANCE_ID = Request.ServerVariables("INSTANCE_ID")
		CVG_INSTANCE_META_PATH = Request.ServerVariables("INSTANCE_META_PATH")
		CVG_LOCAL_ADDR = Request.ServerVariables("LOCAL_ADDR")
		CVG_LOGON_USER = Request.ServerVariables("LOGON_USER")
		CVG_PATH_INFO = Request.ServerVariables("PATH_INFO")
		CVG_PATH_TRANSLATED = Request.ServerVariables("PATH_TRANSLATED")
		CVG_QUERY_STRING = Request.ServerVariables("QUERY_STRING")
		CVG_REMOTE_ADDR = Request.ServerVariables("REMOTE_ADDR")
		CVG_REMOTE_HOST = Request.ServerVariables("REMOTE_HOST")
		CVG_REMOTE_USER = Request.ServerVariables("REMOTE_USER")
		CVG_REQUEST_METHOD = Request.ServerVariables("REQUEST_METHOD")
		CVG_SCRIPT_NAME = Request.ServerVariables("SCRIPT_NAME")
		CVG_SERVER_NAME = Request.ServerVariables("SERVER_NAME")
		CVG_SERVER_PORT = Request.ServerVariables("SERVER_PORT")
		CVG_SERVER_PORT_SECURE = Request.ServerVariables("SERVER_PORT_SECURE")
		CVG_SERVER_PROTOCOL = Request.ServerVariables("SERVER_PROTOCOL")
		CVG_SERVER_SOFTWARE = Request.ServerVariables("SERVER_SOFTWARE")
		CVG_URL = Request.ServerVariables("URL")

%>