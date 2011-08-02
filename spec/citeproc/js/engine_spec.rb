require 'spec_helper'

module CiteProc
  module JS
    describe 'Engine' do

      let(:subject) do
        Engine.new do |e|
          p = double(:processor)
          p.stub(:options).and_return { Processor.defaults }
          p.stub(:abbreviations).and_return { { :default => {} } }
          p.stub(:items).and_return { {} }
          e.processor = p
          e.style = load_style('apa')
          e.locales = { :'en-US' => load_locale('en-US') }
        end
      end
      
      it { should_not be nil }
      
      describe '#version' do
        it 'returns a 1.x version string' do
          subject.version.should =~ /^1\.[\d\.]+/
        end
      end

      describe '#name' do
        it 'returns "citeproc-js"' do
          subject.name.should == 'citeproc-js'
        end
      end
      
      describe '#type' do
        it 'returns "CSL"' do
          subject.type.should == 'CSL'
        end
      end
      
      describe '#processor_version' do
        before(:each) { subject.start }
        after(:each) { subject.stop }
        
        it 'returns the citeproc-js version' do
          subject.processor_version.should =~ /^[\d\.]+$/
        end
      end
      
    end  
  end
end