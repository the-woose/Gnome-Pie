/* 
Copyright (c) 2011 by Simon Schneegans

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>. 
*/

using GnomePie.Settings;

namespace GnomePie {

    public class Preferences : Gtk.Window {
        
        // Many thanks to the synapse-project, since much of this code is taken from there!
        public Preferences() {
            title = "Gnome-Pie - Settings";
            set_position(Gtk.WindowPosition.CENTER);
            set_size_request(500, 450);
            resizable = false;
            delete_event.connect(hide_on_delete);
            
            // main container
            var main_vbox = new Gtk.VBox(false, 12);
                main_vbox.border_width = 12;
                add(main_vbox);

                // tab container
                var tabs = new Gtk.Notebook();
                
                    // general tab
                    var general_tab = new Gtk.VBox(false, 6);
                        general_tab.border_width = 12;
                        
                        // behavior frame
                        var behavior_frame = new Gtk.Frame(null);
                            behavior_frame.set_shadow_type(Gtk.ShadowType.NONE);
                            var behavior_frame_label = new Gtk.Label(null);
                            behavior_frame_label.set_markup(Markup.printf_escaped ("<b>%s</b>", "Behavior"));
                            behavior_frame.set_label_widget(behavior_frame_label);

                            var behavior_vbox = new Gtk.VBox (false, 6);
                            var align = new Gtk.Alignment (0.5f, 0.5f, 1.0f, 1.0f);
                            align.set_padding (6, 12, 12, 12);
                            align.add (behavior_vbox);
                            behavior_frame.add (align);

                            // Autostart checkbox
                            var autostart = new Gtk.CheckButton.with_label ("Startup on Login");
                                //autostart.active = 
                                autostart.toggled.connect(autostart_toggled);
                                behavior_vbox.pack_start (autostart, false);

                            // Notification icon 
                            var indicator = new Gtk.CheckButton.with_label ("Show Indicator");
                                indicator.active = setting().show_indicator;
                                indicator.toggled.connect(indicator_toggled);
                                behavior_vbox.pack_start (indicator, false);
                                
                            // Notification icon 
                            var open_at_mouse = new Gtk.CheckButton.with_label ("Open Rings at Mouse");
                                open_at_mouse.active = setting().open_at_mouse;
                                open_at_mouse.toggled.connect(open_at_mouse_toggled);
                                behavior_vbox.pack_start (open_at_mouse, false);

                        general_tab.pack_start (behavior_frame, false);
                        
                        // theme frame
                        var theme_frame = new Gtk.Frame(null);
                            theme_frame.set_shadow_type(Gtk.ShadowType.NONE);
                            var theme_frame_label = new Gtk.Label(null);
                            theme_frame_label.set_markup(Markup.printf_escaped("<b>%s</b>", "Themes"));
                            theme_frame.set_label_widget(theme_frame_label);
                            
                            // scrollable frame
                            var scroll = new Gtk.ScrolledWindow (null, null);
                                align = new Gtk.Alignment(0.5f, 0.5f, 1.0f, 1.0f);
                                align.set_padding(6, 12, 12, 12);
                                align.add(scroll);
                                theme_frame.add(align);

                                scroll.set_policy (Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC);
                                scroll.set_shadow_type (Gtk.ShadowType.IN);
                                
                                // themes list
                                var theme_list = new ThemeList();
                                    theme_list.show();
                                    scroll.add_with_viewport(theme_list);
                                    
                             scroll.show();

                    general_tab.pack_start (theme_frame, true, true);
                    tabs.append_page(general_tab, new Gtk.Label("General"));
                    
                    // rings tab
                    var rings_tab = new Gtk.VBox(false, 6);
                        rings_tab.border_width = 12;
                        tabs.append_page(rings_tab, new Gtk.Label("Rings"));
                    
                    main_vbox.pack_start(tabs);

                // close button 
                var bbox = new Gtk.HButtonBox ();
                    bbox.set_layout (Gtk.ButtonBoxStyle.END);
                    var close_button = new Gtk.Button.from_stock (Gtk.Stock.CLOSE);
                    close_button.clicked.connect (() => { hide (); });
                    bbox.pack_start (close_button);

                    main_vbox.pack_start(bbox, false);
                    
                main_vbox.show_all ();
        }
        
        private void autostart_toggled(Gtk.ToggleButton check_box) {
            debug("Autostart toggled!");
        }
        
        private void indicator_toggled(Gtk.ToggleButton check_box) {
            var check = check_box as Gtk.CheckButton;
            setting().show_indicator = check.active;
        }
        
        private void open_at_mouse_toggled(Gtk.ToggleButton check_box) {
            var check = check_box as Gtk.CheckButton;
            setting().open_at_mouse = check.active;
        }
    }
}