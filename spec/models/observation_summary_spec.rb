require 'spec_helper'

describe ObservationSummary do
  describe "First Observation" do
    before(:all) do
      @observation = FactoryGirl.create(:observation)
      # First Block
      @observation.interactions.create(minute: 0, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(management))
      @observation.interactions.create(minute: 1, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(management))
      @observation.interactions.create(minute: 2, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(management))
      @observation.interactions.create(minute: 3, on_task: 3, using_technology: false, teacher: %w(presenting circulating answering), students: %w(listening), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 4, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(pair), topic: %w(course_content))
      # Second Block
      @observation.interactions.create(minute: 5, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(reading_writing), grouping: %w(individual pair), topic: %w(course_content))
      @observation.interactions.create(minute: 6, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(reading_writing listening), grouping: %w(individual whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 7, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(individual), topic: %w(course_content))
      @observation.interactions.create(minute: 8, on_task: 2, using_technology: false, teacher: %w(answering), students: %w(reading_writing), grouping: %w(individual), topic: %w(course_content))
      @observation.interactions.create(minute: 9, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening other), grouping: %w(individual whole_group), topic: %w(management))
      # Third Block
      @observation.interactions.create(minute: 10, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 11, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 12, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 13, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 14, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      # Fourth Block
      @observation.interactions.create(minute: 15, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 16, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering listening other), grouping: %w(whole_group), topic: %w(management))
      @observation.interactions.create(minute: 17, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(listening), grouping: %w(other_group), topic: %w(other_topic))
      @observation.interactions.create(minute: 18, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering reading_writing), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 19, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      # Fifth Block
      @observation.interactions.create(minute: 20, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 21, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering other), grouping: %w(whole_group), topic: %w(course_content management other_topic))
      @observation.interactions.create(minute: 22, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 23, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 24, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(course_content))
      # Sixth Block
      @observation.interactions.create(minute: 25, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering listening), grouping: %w(whole_group), topic: %w(course_content), note: 'Discussing what was seen in the movie')
      @observation.interactions.create(minute: 26, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering listening), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 27, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(management))
      @observation.interactions.create(minute: 28, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(management))
      @observation.interactions.create(minute: 29, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(listening), grouping: %w(fluid), topic: %w(management))
      # Seventh Block
      @observation.interactions.create(minute: 30, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing other), grouping: %w(fluid), topic: %w(course_content), note: 'Making paper books')
      @observation.interactions.create(minute: 31, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(fluid), topic: %w(course_content))
      @observation.interactions.create(minute: 32, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(fluid), topic: %w(course_content))
      @observation.interactions.create(minute: 33, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(fluid), topic: %w(course_content management))
      @observation.interactions.create(minute: 34, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(fluid), topic: %w(course_content))
      # Eighth Block
      @observation.interactions.create(minute: 35, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(individual fluid), topic: %w(course_content))
      @observation.interactions.create(minute: 36, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(individual fluid), topic: %w(course_content))
      @observation.interactions.create(minute: 37, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(fluid), topic: %w(course_content))
      @observation.interactions.create(minute: 38, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group fluid), topic: %w(course_content))
      @observation.interactions.create(minute: 39, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(individual fluid), topic: %w(course_content))

    end

    subject { ObservationSummary.new(observation) }
    let(:observation) { @observation }

    context "first block" do
      describe '#summary_code_string' do
        it "is PLwm" do
          subject.summary_code_string(from: 0, to: 4).should eq 'PLwm'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 0, to: 4).should eq false
        end
      end
      describe '#on_task' do
        it 'is "2"' do
          subject.on_task(from: 0, to: 4).should eq 2
        end
      end
      describe '#teacher_counts' do
        it 'accurately counts the occurrences of each teacher code' do
          correct_counts = { "Presenting" => 6, "Circulating" => 2}
          subject.teacher_counts.should eq correct_counts
        end
      end
    end

    context "second block" do
      describe '#summary_code_string' do
        it "is PRWicc" do
          subject.summary_code_string(from: 5, to: 9).should eq 'PRWicc'
        end
      end
      describe '#using_technology?' do
        it "is false" do
          subject.using_technology?(from: 5, to: 9).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 5, to: 9).should eq 1
        end
      end
    end

    context "third block" do
      describe '#summary_code_string' do
        it "is PAwcc" do
          subject.summary_code_string(from: 10, to: 14).should eq 'PAwcc'
        end
      end
      describe '#using_technology?' do
        it "is false" do
          subject.using_technology?(from: 10, to: 14).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 10, to: 14).should eq 1
        end
      end
    end

    context "fourth block" do
      describe '#summary_code_string' do
        it "is PAwcc" do
          subject.summary_code_string(from: 15, to: 19).should eq 'PAwcc'
        end
      end
      describe '#using_technology?' do
        it "is true" do
          subject.using_technology?(from: 15, to: 19).should eq false
        end
      end
      describe '#on_task' do
        it 'is "2"' do
          subject.on_task(from: 15, to: 19).should eq 2
        end
      end
    end

    context "fifth block" do
      describe '#summary_code_string' do
        it "is PAwcc" do
          subject.summary_code_string(from: 20, to: 24).should eq 'PAwcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 20, to: 24).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 20, to: 24).should eq 1
        end
      end
    end

    context "sixth block" do
      describe '#summary_code_string' do
        it "is PLwm" do
          subject.summary_code_string(from: 25, to: 29).should eq 'PLwm'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 25, to: 29).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 25, to: 29).should eq 1
        end
      end
    end

    context "seventh block" do
      describe '#summary_code_string' do
        it "is CDfcc" do
          subject.summary_code_string(from: 30, to: 34).should eq 'CDfcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 30, to: 34).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 30, to: 34).should eq 2
        end
      end
    end

    context "Eighth block" do
      describe '#summary_code_string' do
        it "is CDfcc" do
          subject.summary_code_string(from: 35, to: 39).should eq 'CDfcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 35, to: 39).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 35, to: 39).should eq 2
        end
      end
    end
  end


  describe "Second Observation" do
    before(:all) do
      @observation = FactoryGirl.create(:observation)
      # First Block
      @observation.interactions.create(minute: 0, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 1, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering listening), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 2, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 3, on_task: 3, using_technology: false, teacher: %w(circulating), students: %w(other), grouping: %w(fluid), topic: %w(management), note: 'Handing out papers for oral vocabulary quiz')
      @observation.interactions.create(minute: 4, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(reading_writing listening), grouping: %w(individual), topic: %w(course_content))
      # Second Block
      @observation.interactions.create(minute: 5, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(reading_writing), grouping: %w(individual), topic: %w(course_content), note: 'Vocabulary test')
      @observation.interactions.create(minute: 6, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(reading_writing answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 7, on_task: 1, using_technology: false, teacher: %w(answering), students: %w(reading_writing discussing), grouping: %w(individual whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 8, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 9, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content), note: 'Beginning Review')
      # Third Block
      @observation.interactions.create(minute: 10, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(individual), topic: %w(course_content))
      @observation.interactions.create(minute: 11, on_task: 1, using_technology: true, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content), note: 'Preparing Smartboard for Presentation')
      @observation.interactions.create(minute: 12, on_task: 1, using_technology: true, teacher: %w(answering), students: %w(answering), grouping: %w(individual whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 13, on_task: 2, using_technology: true, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 14, on_task: 2, using_technology: true, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      # Fourth Block
      @observation.interactions.create(minute: 15, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 16, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 17, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 18, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 19, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing), grouping: %w(pair), topic: %w(course_content))
      # Fifth Block
      @observation.interactions.create(minute: 20, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 21, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 22, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 23, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 24, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(course_content))
      # Sixth Block
      @observation.interactions.create(minute: 25, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair), topic: %w(course_content), note: 'Discussing what was seen in the movie')
      @observation.interactions.create(minute: 26, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 27, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 28, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 29, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair), topic: %w(course_content))
      # Seventh Block
      @observation.interactions.create(minute: 30, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair), topic: %w(course_content), note: 'Pair writing lists')
      @observation.interactions.create(minute: 31, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair whole_group), topic: %w(course_content management), note: 'Explaining management instructions in French')
      @observation.interactions.create(minute: 32, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair whole_group), topic: %w(course_content management), note: 'Explaining management instructions in French')
      @observation.interactions.create(minute: 33, on_task: 1, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(pair), topic: %w(course_content))
      @observation.interactions.create(minute: 34, on_task: 2, using_technology: false, teacher: %w(circulating), students: %w(discussing reading_writing), grouping: %w(fluid), topic: %w(course_content))
      # Eighth Block
      @observation.interactions.create(minute: 35, on_task: 2, using_technology: false, teacher: %w(presenting), students: %w(listening), grouping: %w(whole_group), topic: %w(course_content), note: 'Pair writing lists')
      @observation.interactions.create(minute: 36, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content management), note: 'Explaining management instructions in French')
      @observation.interactions.create(minute: 37, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content management), note: 'Explaining management instructions in French')
      @observation.interactions.create(minute: 38, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))
      @observation.interactions.create(minute: 39, on_task: 1, using_technology: false, teacher: %w(presenting), students: %w(answering), grouping: %w(whole_group), topic: %w(course_content))

    end

    subject { ObservationSummary.new(observation) }
    let(:observation) { @observation }

    context 'full observation' do
      describe '#teacher_counts' do
        it 'accurately counts to teacher code from the summary strings' do
          correct_counts = { "Presenting" => 5, "Circulating" => 3 }
          subject.teacher_counts.should eq correct_counts
        end
      end
      describe '#on_task_counts' do
        it 'accurately counts the on_task values from the total observation' do
          correct_counts = { :"1" => 5, :"2" => 3 }
          subject.on_task_counts.should eq correct_counts
        end
      end
    end

    context "first block" do
      describe '#summary_code_string' do
        it "is PLwcc" do
          subject.summary_code_string(from: 0, to: 4).should eq 'PLwcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 0, to: 4).should eq false
        end
      end
      describe '#on_task' do
        it 'is "2"' do
          subject.on_task(from: 0, to: 4).should eq 2
        end
      end
    end

    context "second block" do
      describe '#summary_code_string' do
        it "is PRWwcc for the second set of interactions" do
          subject.summary_code_string(from: 5, to: 9).should eq 'PRWwcc'
        end
      end
      describe '#using_technology?' do
        it "is false" do
          subject.using_technology?(from: 5, to: 9).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 5, to: 9).should eq 1
        end
      end
    end

    context "third block" do
      describe '#summary_code_string' do
        it "is PAwcc" do
          subject.summary_code_string(from: 10, to: 14).should eq 'PAwcc'
        end
      end
      describe '#using_technology?' do
        it "is true" do
          subject.using_technology?(from: 10, to: 14).should eq true
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 10, to: 14).should eq 1
        end
      end
    end

    context "fourth block" do
      describe '#summary_code_string' do
        it "is CDpcc" do
          subject.summary_code_string(from: 15, to: 19).should eq 'CDpcc'
        end
      end
      describe '#using_technology?' do
        it "is true" do
          subject.using_technology?(from: 15, to: 19).should eq false
        end
      end
      describe '#on_task' do
        it 'is "2"' do
          subject.on_task(from: 15, to: 19).should eq 2
        end
      end
    end

    context "fifth block" do
      describe '#summary_code_string' do
        it "is PAwcc" do
          subject.summary_code_string(from: 20, to: 24).should eq 'PAwcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 20, to: 24).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 20, to: 24).should eq 1
        end
      end
    end

    context "sixth block" do
      describe '#summary_code_string' do
        it "is CDpcc" do
          subject.summary_code_string(from: 25, to: 29).should eq 'CDpcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 25, to: 29).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 25, to: 29).should eq 1
        end
      end
    end

    context "seventh block" do
      describe '#summary_code_string' do
        it "is CDpcc" do
          subject.summary_code_string(from: 30, to: 34).should eq 'CDpcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 30, to: 34).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 30, to: 34).should eq 2
        end
      end
    end

    context "Eighth block" do
      describe '#summary_code_string' do
        it "is PAwcc" do
          subject.summary_code_string(from: 35, to: 39).should eq 'PAwcc'
        end
      end
      describe '#using_technology?' do
        it "is false for the first set of interactions" do
          subject.using_technology?(from: 35, to: 39).should eq false
        end
      end
      describe '#on_task' do
        it 'is "1"' do
          subject.on_task(from: 35, to: 39).should eq 1
        end
      end
    end
  end
end