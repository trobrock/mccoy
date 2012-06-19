Mail.defaults do
  retriever_method :imap,
    :address    => "imap.gmail.com",
    :port       => 993,
    :user_name  => 'test@outright.com',
    :password   => 'testpassword',
    :enable_ssl => true
end
