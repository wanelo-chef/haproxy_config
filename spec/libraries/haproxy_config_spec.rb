require 'spec_helper'

describe HaproxyConfig do
  let(:config) { HaproxyConfig.instance }

  describe '#sections' do
    it 'be an enumerable' do
      expect(config.sections).to be_a_kind_of(Enumerable)
    end
  end

  describe '#reset' do
    it 'clears sections' do
      config.sections << "thing"
      expect {
        config.reset
      }.to change {
        config.sections.empty?
      }.to(true)
    end
  end

  describe '#to_s' do
    it 'calls #to_s on all sections and joins with \n\n' do
      section1 = double(to_s: "section 1")
      section2 = double(to_s: "section 2")

      config.sections << section1
      config.sections << section2

      expect(config.to_s).to eq(<<-END.gsub(/^[ ]{8}/, ''))
        section 1

        section 2
      END
    end
  end
end

