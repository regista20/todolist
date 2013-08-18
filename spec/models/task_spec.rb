# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Task do

  let(:user) { FactoryGirl.create(:user) }
  before { @task = user.tasks.build(content: "add task") }

  subject { @task }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Task.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @task.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @task.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @task.content = "a" * 141 }
    it { should_not be_valid }
  end
end
