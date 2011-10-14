require 'chef/provider/package'
require 'chef/resource/package'
require 'chef/platform'


class Chef
  class Provider
    class Package
      class IPS < Package

        def load_current_resource
          @current_resource = Chef::Resource::Package.new(@new_resource.name)
          @current_resource.package_name(@new_resource.package_name)
          @current_resource.version(current_installed_version)

          @current_resource
        end

        def install_package(name, version)
          pkg('install', name)
        end

        def upgrade_package(name, version)
          stub_upgrade_method(name, version)
        end

        def remove_package(name, version)
          pkg('uninstall', name)
        end

        def purge_package(name, version)
          stub_purge_package(name, version)
        end

        private

        def pkg(*args)
          run_command_with_systems_locale(:command => "pkg #{args.join(' ')}")
        end

        def current_installed_version
          get_version_from_command("pkg list -Hv #{@new_resource.package_name} | sed 's/.*@\([^,]*\).*/\1/'")
        end

        def candidate_version
          get_version_from_command("pkg list -Hnv #{@new_resource.package_name} | sed 's/.*@\([^,]*\).*/\1/'")
        end

        def get_version_from_command(command)
          version = get_response_from_command(command).chomp
          version.empty? ? nil : version
        end

        def get_response_from_command(command)
          output = nil
          status = popen4(command) do |pid, stdin, stdout, stderr|
            begin
              output = stdout.read
            rescue Exception => e
              raise Chef::Exceptions::Package, "Could not read from STDOUT on command: #{command}\nException: #{e.inspect}"
            end
          end
          unless (0..1).include? status.exitstatus
            raise Chef::Exceptions::Package, "#{command} failed - #{status.inspect}"
          end
          output
        end

        def stub_upgrade_method(name, version)
          install_package(name, version)
        end

        def stub_purge_package(name, version)
          remove_package(name, version)
        end

      end
    end
  end
end

Chef::Platform.set :platform => :solaris2, :resource => :package, :provider => Chef::Provider::Package::IPS

