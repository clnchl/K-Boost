import { AppService } from './app.service';
export declare class AppController {
    private readonly appService;
    constructor(appService: AppService);
    getHome(): {
        name: string;
        status: string;
        version: string;
    };
}
