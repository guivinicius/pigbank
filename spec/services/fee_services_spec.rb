require "spec_helper"

describe FeeService do

  describe "#calculate" do

    after do
      Timecop.return
    end

    context "when amount is less than 1000" do

      context "and is weekend" do

        it "returns 7" do
          Timecop.freeze(Time.new.end_of_week)
          expect(FeeService.new(100, Time.zone.now).calculate).to eq(7)
        end

      end

      context "and is not weekend" do

        context "and is 8am" do
          it "returns 7" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 8))
            expect(FeeService.new(100, Time.zone.now).calculate).to eq(7)
          end
        end

        context "and is 9am" do
          it "returns 5" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 10))
            expect(FeeService.new(100, Time.zone.now).calculate).to eq(5)
          end
        end

        context "and is 12am" do
          it "returns 5" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 12))
            expect(FeeService.new(100, Time.zone.now).calculate).to eq(5)
          end
        end

        context "and is 18pm" do
          it "returns 5" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 18))
            expect(FeeService.new(100, Time.zone.now).calculate).to eq(5)
          end
        end

        context "and is 20pm" do
          it "returns 7" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 20))
            expect(FeeService.new(100, Time.zone.now).calculate).to eq(7)
          end
        end

      end

    end

    context "when amount is more than 1000" do
      context "and is weekend" do

        it "returns 17" do
          Timecop.freeze(Time.new.end_of_week)
          expect(FeeService.new(10000, Time.zone.now).calculate).to eq(17)
        end

      end

      context "and is not weekend" do

        context "and is 8am" do
          it "returns 17" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 8))
            expect(FeeService.new(10000, Time.zone.now).calculate).to eq(17)
          end
        end

        context "and is 9am" do
          it "returns 15" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 10))
            expect(FeeService.new(10000, Time.zone.now).calculate).to eq(15)
          end
        end

        context "and is 12am" do
          it "returns 15" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 12))
            expect(FeeService.new(10000, Time.zone.now).calculate).to eq(15)
          end
        end

        context "and is 18pm" do
          it "returns 15" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 18))
            expect(FeeService.new(10000, Time.zone.now).calculate).to eq(15)
          end
        end

        context "and is 20pm" do
          it "returns 17" do
            Timecop.freeze(Time.new.beginning_of_week.change(:hour => 20))
            expect(FeeService.new(10000, Time.zone.now).calculate).to eq(17)
          end
        end

      end

    end

  end

end