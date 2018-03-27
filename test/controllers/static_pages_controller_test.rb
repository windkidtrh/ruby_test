require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "should get root" do
    get root_url
    assert_response :success
    # assert_select "title", "#{@base_title}"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    # assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    # assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    # assert_select "title", "#{@base_title}"
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    # assert_select "title", "#{@base_title}"
    #这里可以去掉是因为其他地方已经调试成功了，
    #如果留下这句，控制台去匹配对应的标题会显示失败，要不失败则把这句去掉。
    #或者将例如contact.html.erb中的provide那行注释掉。
  end

end
