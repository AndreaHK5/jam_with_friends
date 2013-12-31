require 'spec_helper'

describe RegistrationsController do

  describe "GET 'after_sign_up_path_for'" do
    it "returns http success" do
      get 'after_sign_up_path_for'
      response.should be_success
    end
  end

end
