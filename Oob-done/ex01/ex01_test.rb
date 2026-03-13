#!/usr/bin/env ruby
$VERBOSE = true

require_relative 'ex01'

def banner(title)
  puts "\n=== #{title} ==="
end

def pass(message)
  puts "[OK] #{message}"
end

def fail_case(message)
  puts "[KO] #{message}"
end

def expect_error(label, expected_message)
  begin
    yield
    fail_case("#{label} -> aucune erreur levee")
  rescue StandardError => e
    if e.message == expected_message
      pass("#{label} -> #{e.message}")
    else
      fail_case("#{label} -> message inattendu: '#{e.message}'")
      puts "      attendu: '#{expected_message}'"
    end
  end
end

def cleanup(*names)
  names.each do |name|
    file = "#{name}.html"
    File.delete(file) if File.exist?(file)
  end
end

if $PROGRAM_NAME == __FILE__
  cleanup('test', 'nobody_case', 'closed_case')

  banner('Cas nominal')
  page = Html.new('test')
  page.dump('Lorem_ipsum')
  page.finish
  pass('creation + dump + finish sans erreur')

  banner('Erreurs attendues')

  expect_error('fichier deja existant', 'test.html already exist!') do
    Html.new('test')
  end

  no_body = Html.new('nobody_case')
  File.write('nobody_case.html', "<!DOCTYPE html>\n<html>\n<head>\n<title>nobody_case</title>\n</head>\n")
  expect_error('dump sans balise body ouvrante', 'There is no body tag in nobody_case.html') do
    no_body.dump('Lorem_ipsum')
  end

  closed = Html.new('closed_case')
  closed.finish
  expect_error('dump apres body ferme', 'Body has already been closed in closed_case.html') do
    closed.dump('Lorem_ipsum')
  end

  expect_error('finish appele deux fois', 'closed_case.html has already been closed') do
    closed.finish
  end

  banner('Nettoyage')
  cleanup('test', 'nobody_case', 'closed_case')
  pass('fichiers temporaires supprimes')
end
