require "google/apis/drive_v3"
require "googleauth"
require "googleauth/stores/file_token_store"

OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "eval".freeze
CREDENTIALS_PATH = "credentials.json".freeze

# create token.yaml after initial OAuth2 authorization
# store access and refresh tokens in token.yaml
TOKEN_PATH = "token.yaml".freeze
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials

# authorize user with saved credential files or initial OAuth2 authorization
def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = "default"
  credentials = authorizer.get_credentials user_id

  # launch default browser to approve request of initial OAuth2 authorization
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts "Open the following URL in the browser and enter the resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
  end

  credentials
end

# check if report already exists
def exists(files)
  files.each do |f|
    if f.name == 'Code Review Report'
      return f.id
    end
  end
  false
end

# initialize API
drive_service = Google::Apis::DriveV3::DriveService.new
drive_service.client_options.application_name = APPLICATION_NAME
drive_service.authorization = authorize

# delete report if it already exists
files = drive_service.list_files(q: 'trashed=false').files
if exists(files)
  drive_service.delete_file(exists(files))
end

# generate and upload report
file_metadata = {
    name: 'Code Review Report',
    mime_type: 'application/vnd.google-apps.document'
}

file = drive_service.create_file(file_metadata,
                                 fields: 'webViewLink',
                                 upload_source: '../output/output.txt',
                                 content_type: 'text/plain')

# return link to report
puts "#{file.web_view_link}"
