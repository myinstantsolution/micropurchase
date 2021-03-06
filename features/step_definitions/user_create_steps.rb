Given(/^I am a user with a verified SAM account$/) do
  @user = FactoryGirl.create(
    :user,
    sam_status: :sam_accepted,
    github_id: '123451',
    duns_number: FakeSamApi::VALID_DUNS
  )
  @github_id = @user.github_id
  mock_sign_in(@user.github_id, @user.name)
end

Given(/^I am a user with a verified SAM account who is not a small business$/) do
  @user = FactoryGirl.create(
    :user,
    sam_status: :sam_accepted,
    github_id: '123451',
    duns_number: FakeSamApi::VALID_DUNS,
    small_business: false
  )
  @github_id = @user.github_id
  mock_sign_in(@user.github_id, @user.name)
end

Given(/^I am a user without a verified SAM account$/) do
  @user = FactoryGirl.create(
    :user,
    sam_status: :sam_pending,
    github_id: '123451',
    duns_number: FakeSamApi::INVALID_DUNS
  )
  @github_id = @user.github_id
  mock_sign_in(@user.github_id, @user.name)
end

Given(/^I am a user without a DUNS number$/) do
  @user = FactoryGirl.create(:user, github_id: '123451', duns_number: '')
  @github_id = @user.github_id
  mock_sign_in(@user.github_id, @user.name)
end

Given(/^I am an administrator$/) do
  @user = FactoryGirl.create(:admin_user)
  @github_id = @user.github_id
  mock_sign_in(@user.github_id, @user.name)
end

Given(/^I am an administrator with a login.gov account$/) do
  @user = FactoryGirl.create(:admin_user, uid: "12345")
  @uid = @user.uid
  mock_saml_sign_in(@uid)
end

Given(/^I am a regular user with a login.gov account$/) do
  @user = FactoryGirl.create(:user, uid: "12345")
  @uid = @user.uid
  mock_saml_sign_in(@uid)
end

Given(/^I am a contracting officer$/) do
  @user = FactoryGirl.create(:contracting_officer)
  @github_id = @user.github_id
  mock_sign_in(@user.github_id, @user.name)
end

Given(/^there is a user in SAM.gov who is not a small business$/) do
  @user = FactoryGirl.create(:user, sam_status: :sam_accepted, small_business: false)
end

Given(/^there is a user in SAM.gov who is a small business$/) do
  @user = FactoryGirl.create(:user, sam_status: :sam_accepted, small_business: true)
end

Given(/^there is a user who is not in SAM.gov$/) do
  @user = FactoryGirl.create(:user, sam_status: :sam_pending)
end

Given(/^there are users in the system$/) do
  @user = FactoryGirl.create(:user)
end

Given(/^there is a user in the system who has bid on an auction$/) do
  @user = FactoryGirl.create(:user, sam_status: :sam_accepted)
  @auction = FactoryGirl.create(:auction, :closed, bidders: [@user])
end
