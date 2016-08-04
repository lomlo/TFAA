require "rails_helper"

describe Choice, type: :model do

  scenario "choice can be created" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    expect{create( :choice, chapter_id: chapter.id)}.to change{Choice.count}.by(1)
  end


  scenario "HELLO" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    choice = create(:choice, chapter_id: chapter.id )
    expect{choice.normalize_blank_values}.not_to raise_error
  end

end
