require "google/apis/drive_v3"
require "googleauth"
require "googleauth/stores/file_token_store"

OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "eval".freeze
CREDENTIALS_PATH = "credentials.json".freeze
TOKEN_PATH = "token.yaml".freeze
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE

def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = "default"
  credentials = authorizer.get_credentials user_id

  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts "Open the following URL in the browser and enter the resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
  end

  credentials
end

drive_service = Google::Apis::DriveV3::DriveService.new
drive_service.client_options.application_name = APPLICATION_NAME
drive_service.authorization = authorize

f_meta = { name: 'test.txt' }
file = drive_service.create_file(f_meta, fields: 'id', upload_source: 'test.txt', content_type: 'text/plain')
puts "File Id: #{file.id}"
