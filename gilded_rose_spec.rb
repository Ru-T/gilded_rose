require_relative './gilded_rose'

describe "#update_quality" do

  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before(:each) { update_quality([item]) }

    context "normal item" do
      let(:name) { "NORMAL ITEM" }

      describe "#sell_in" do
        it "decreases by 1" do
          expect(item.sell_in).to eq initial_sell_in-1
        end
      end

      describe "#quality" do
        context "before sell date" do
          it "decreases by 1" do
            expect(item.quality).to eq(initial_quality-1)
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it "decreases by 2" do
            expect(item.quality).to eq(initial_quality-2)
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it "decreases by 2" do
            expect(item.quality).to eq(initial_quality-2)
          end
        end

        context "with zero quality" do
          let(:initial_quality) { 0 }
          it "doesn't change" do
            expect(item.quality).to eq(0)
          end
        end
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }

      describe "#sell_in" do
        it "decreases by 1" do
          expect(item.sell_in).to eq(initial_sell_in-1)
        end
      end

      describe "#quality" do
        context "before sell date" do
          it "increases by 1" do
            expect(item.quality).to eq(initial_quality+1)
          end

          context "with max quality" do
            let(:initial_quality) { 50 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it "increases by 2" do
            expect(item.quality).to eq(initial_quality+2)
          end

          context "near max quality" do
            let(:initial_quality) { 49 }
            it "doesn't change" do
              expect(item.quality).to eq(50)
            end
          end

          context "with max quality" do
            let(:initial_quality) { 50 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it "increases by 2" do
            expect(item.quality).to eq(initial_quality+2)
          end

          context "with max quality" do
            let(:initial_quality) { 50 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end
      end
    end

    context "Sulfuras" do
      let(:initial_quality) { 80 }
      let(:name) { "Sulfuras, Hand of Ragnaros" }

      describe "#sell_in" do
        it "doesn't change" do
          expect(item.sell_in).to eq(initial_sell_in)
        end
      end

      describe "#quality" do
        context "before sell date" do
          it "doesn't change" do
            expect(item.quality).to eq(initial_quality)
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it "doesn't change" do
            expect(item.quality).to eq(initial_quality)
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it "doesn't change" do
            expect(item.quality).to eq(initial_quality)
          end
        end
      end
    end

    context "Backstage pass" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

      describe "#sell_in" do
        it "decreases by 1" do
           expect(item.sell_in).to eq(initial_sell_in-1)
        end
      end

      context "#quality" do
        context "long before sell date" do
          let(:initial_sell_in) { 11 }
          it "increases by 1" do
            expect(item.quality).to eq(initial_quality+1)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
          end
        end

        context "medium close to sell date (upper bound)" do
          let(:initial_sell_in) { 10 }
          it "increases by 2" do
            expect(item.quality).to eq(initial_quality+2)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "medium close to sell date (lower bound)" do
          let(:initial_sell_in) { 6 }
          it "increases by 2" do
            expect(item.quality).to eq(initial_quality+2)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "very close to sell date (upper bound)" do
          let(:initial_sell_in) { 5 }
          it "increases by 3" do
            expect(item.quality).to eq(initial_quality+3)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "very close to sell date (lower bound)" do
          let(:initial_sell_in) { 1 }
          it "increases by 3" do
            expect(item.quality).to eq(initial_quality+3)
          end

          context "at max quality" do
            let(:initial_quality) { 50 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it "is zero" do
            expect(item.quality).to eq(0)
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it "is zero" do
            expect(item.quality).to eq(0)
          end
        end
      end
    end

    context "conjured item" do
      # before { skip "Conjured items are not implemented yet" }
      let(:name) { "Conjured Mana Cake" }

      describe "#sell_in" do
        it "decreases by 1" do
          expect(item.sell_in).to eq(initial_sell_in-1)
        end
      end

      describe "#quality" do
        context "before the sell date" do
          let(:initial_sell_in) { 5 }
          it "decreases by 2" do
            expect(item.quality).to eq(initial_quality-2)
          end

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "on sell date" do
          let(:initial_sell_in) { 0 }
          it "decreases by 4" do
            expect(item.quality).to eq(initial_quality-4)
          end

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end

        context "after sell date" do
          let(:initial_sell_in) { -10 }
          it "decreases by 4" do
            expect(item.quality).to eq(initial_quality-4)
          end

          context "at zero quality" do
            let(:initial_quality) { 0 }
            it "doesn't change" do
              expect(item.quality).to eq(initial_quality)
            end
          end
        end
      end
    end
  end

  context "with several objects, before sell by date" do
    let(:items) {
      [
        Item.new("NORMAL ITEM", 5, 10),
        Item.new("Aged Brie", 3, 10),
      ]
    }

    before(:each) { update_quality(items) }

    context "normal items" do
      it "quality decreases by 1" do
        expect(items[0].quality).to eq(9)
      end
      it "sell_in decreases by 1" do
        expect(items[0].sell_in).to eq(4)
      end
    end

    context "Aged Brie" do
      it "quality increases by 1" do
        expect(items[1].quality).to eq(11)
      end
      it "sell_in decreases by 1" do
        expect(items[1].sell_in).to eq(2)
      end
    end
  end
end
