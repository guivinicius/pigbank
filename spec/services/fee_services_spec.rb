require "spec_helper"

describe FeeService do

  describe "#calculate" do

    context "when amount is less than 1000" do

      context "and is weekend" do

        it "returns 7" do
          expect(FeeService.new(100, Time.new.end_of_week).calculate).to eq(7)
        end

      end

      context "and is not weekend" do

        context "and is 8am" do
          it "returns 7" do
            expect(FeeService.new(100, Time.new.beginning_of_week.change(:hour => 8)).calculate).to eq(7)
          end
        end

        context "and is 9am" do
          it "returns 5" do
            expect(FeeService.new(100, Time.new.beginning_of_week.change(:hour => 9)).calculate).to eq(5)
          end
        end

        context "and is 12am" do
          it "returns 5" do
            expect(FeeService.new(100, Time.new.beginning_of_week.change(:hour => 12)).calculate).to eq(5)
          end
        end

        context "and is 18pm" do
          it "returns 5" do
            expect(FeeService.new(100, Time.new.beginning_of_week.change(:hour => 18)).calculate).to eq(5)
          end
        end

        context "and is 20pm" do
          it "returns 7" do
            expect(FeeService.new(100,Time.new.beginning_of_week.change(:hour => 20)).calculate).to eq(7)
          end
        end

      end

    end

    context "when amount is more than 1000" do
      context "and is weekend" do

        it "returns 17" do
          expect(FeeService.new(10000, Time.new.end_of_week).calculate).to eq(17)
        end

      end

      context "and is not weekend" do

        context "and is 8am" do
          it "returns 17" do
            expect(FeeService.new(10000, Time.new.beginning_of_week.change(:hour => 8)).calculate).to eq(17)
          end
        end

        context "and is 9am" do
          it "returns 15" do
            expect(FeeService.new(10000, Time.new.beginning_of_week.change(:hour => 9)).calculate).to eq(15)
          end
        end

        context "and is 12am" do
          it "returns 15" do
            expect(FeeService.new(10000, Time.new.beginning_of_week.change(:hour => 12)).calculate).to eq(15)
          end
        end

        context "and is 18pm" do
          it "returns 15" do
            expect(FeeService.new(10000, Time.new.beginning_of_week.change(:hour => 18)).calculate).to eq(15)
          end
        end

        context "and is 20pm" do
          it "returns 17" do
            expect(FeeService.new(10000, Time.new.beginning_of_week.change(:hour => 20)).calculate).to eq(17)
          end
        end

      end

    end

  end

end