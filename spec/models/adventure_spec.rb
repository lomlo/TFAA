require "rails_helper"

describe Adventure, type: :model do

  it { should validate_presence_of(:title) }

  it { should validate_uniqueness_of(:title) }

  it { should validate_presence_of(:image) }

  it { should validate_presence_of(:synopsis) }

  scenario "adventure can be created" do
    expect{create( :adventure, title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + 'app/assets/images/Bristol.jpeg', 'image/jpeg') )}.to change{Adventure.count}.by(1)
  end

  scenario "non image type files cannot be added" do
    adventure = 'app/controllers/concerns/.keep'
    adventure_rb = 'app/controllers/adventures_controller.rb'
    adventure_html_erb = 'app/views/adventures/index.html.erb'
    adventure_md = 'README.md'

    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure_rb}", 'image/jpeg'))).to have(1).error_on(:image)
    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure_html_erb}", 'image/jpeg'))).to have(1).error_on(:image)
    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure_md}", 'image/jpeg'))).to have(1).error_on(:image)
    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure}", 'image/jpeg'))).to have(1).error_on(:image)
  end

  scenario "type of image files accepted" do
    jpeg = 'app/assets/images/Bristol.jpeg'
    png = 'app/assets/images/png.png'
    svg = 'app/assets/images/svg.svg'
    gif = 'app/assets/images/giphy.gif'

    expect{create( :adventure, title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{jpeg}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
    expect{create( :adventure, title: "png", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{png}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
    expect{create( :adventure, title: "svg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{svg}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
    expect{create( :adventure, title: "gif", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{gif}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
  end

  scenario "adventure#create_tree can create a nested list for one chapter" do
    choice    = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter   = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice.id)

    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='/adventures/#{adventure.id}/chapters/#{chapter.id}/choices/new'> #{ adventure.first_3_words(chapter) }</a></li></ul>"
  end

  scenario "adventure#create_tree can create a nested list with one parent and one child" do
    choice1    = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter1  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice1.id)
    choice2   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter2  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice2.id)


    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='/adventures/#{adventure.id}/chapters/#{chapter1.id}/choices/new'> #{ adventure.first_3_words(chapter1)}</a><ul><li><a href='/adventures/#{adventure.id}/chapters/#{chapter2.id}/choices/new'> #{ adventure.first_3_words(chapter2)}</a></li></ul></li></ul>"
  end

  scenario "adventure#create_tree can create a nested list with one head and two chapters" do
    choice1   = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter1  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice1.id)
    choice2   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter2  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice2.id)
    choice3   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter3  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice3.id)


    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='/adventures/#{adventure.id}/chapters/#{chapter1.id}/choices/new'> #{ adventure.first_3_words(chapter1)}</a><ul><li><a href='/adventures/#{adventure.id}/chapters/#{chapter2.id}/choices/new'> #{ adventure.first_3_words(chapter2)}</a></li><li><a href='/adventures/#{adventure.id}/chapters/#{chapter3.id}/choices/new'> #{ adventure.first_3_words(chapter3)}</a></li></ul></li></ul>"
  end

  scenario "adventure#tree can create a nested list with one head and three chapters" do
    choice1   = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter1  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice1.id)
    choice2   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter2  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice2.id)
    choice3   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter3  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice3.id)
    choice4   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter4  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice4.id)

    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='/adventures/#{adventure.id}/chapters/#{chapter1.id}/choices/new'> #{ adventure.first_3_words(chapter1)}</a><ul><li><a href='/adventures/#{adventure.id}/chapters/#{chapter2.id}/choices/new'> #{ adventure.first_3_words(chapter2)}</a></li><li><a href='/adventures/#{adventure.id}/chapters/#{chapter3.id}/choices/new'> #{ adventure.first_3_words(chapter3)}</a></li><li><a href='/adventures/#{adventure.id}/chapters/#{chapter4.id}/choices/new'> #{ adventure.first_3_words(chapter4)}</a></li></ul></li></ul>"
  end
end
